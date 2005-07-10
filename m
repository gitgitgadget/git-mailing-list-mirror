From: Dan Holmsand <dan@innehallsbolaget.se>
Subject: Re: [RFC] Design for http-pull on repo with packs
Date: Sun, 10 Jul 2005 21:56:57 +0200
Message-ID: <42D17D89.9080808@innehallsbolaget.se>
References: <Pine.LNX.4.21.0507101226011.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030307050809040908090207"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 21:59:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrhxV-0008Bk-Ui
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 21:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVGJT7G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 15:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbVGJT6x
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 15:58:53 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:53653 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S262092AbVGJT5J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2005 15:57:09 -0400
Received: from [192.168.0.5] holmsand [80.217.52.214]
	by smtp-send.myrealbox.com with NetMail SMTP Agent $Revision: 1.5 $ on Linux
	via secured & encrypted transport (TLS);
	Sun, 10 Jul 2005 13:57:00 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0507101226011.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------030307050809040908090207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Daniel Barkalow wrote:
> I have a design for using http-pull on a packed repository, and it only
> requires one extra file in the repository: an append-only list of the pack
> files (because getting the directory listing is very painful and
> failure-prone).

A few comments (as I've been tinkering with a way to solve the problem 
myself).

As long as the pack files are named sensibly (i.e. if they are created 
by git-repack-script), it's not very error-prone to just get the 
directory listing, and look for matches for pack-<sha1>.idx. It seems to 
work quite well (see below). It isn't beautiful in any way, but it works...

[snip]

>  If an individual file is not available, figure out what packs are
>   available:
> 
>    Get the list of pack files the repository has
>     (currently, I just use "e3117bbaf6a59cb53c3f6f0d9b17b9433f0e4135")
>    For any packs we don't have, get the index files.

This part might be slightly expensive, for large repositories. If one 
assumes that packs are named as by git-repack-script, however, one might 
cache indexes we've already seen (again, see below). Or, if you go for 
the mandatory "pack-index-file", require that it has a reliable order, 
so that you can get the last added index first.

>    Keep a list of the struct packed_gits for the packs the server has
>     (these are not used as places to look for objects)
> 
>  Each time we need an object, check the list for it. If it is in there,
>   download the corresponding pack and report success.

Here you will need some strategy to deal with packs that overlap with 
what we've already got. Basically, small and overlapping packs should be 
unpacked, big and non-overlapping ones saved as is (since 
git-unpack-objects is painfully slow and memory-hungry...).

One could also optimize the pack-download bit, by figuring out the last 
object in the pack that we need (easy enough to do from the index file), 
  and just get the part of the pack file leading up to that object. That 
could be a huge win for independently packed repositories (I don't do 
that in my code below, though).

Anyway, here's my attempt at the same thing. It introduces 
"git-dumb-fetch", with usage like git-fetch-pack (except that it works 
with http and rsync). And it adds some uglyness to git-cat-file, for 
figuring out which objects we already have.

I'm sort of using the same basic strategy as you, except that I check 
the pack files first (I didn't want to mess with http-pull.c, and I 
wanted something that would work with rsync as well).

The strategy is this:

    o Check if the repository has some pack files we haven't seen
      already

    o If there are new pack files, download indexes, and see if
      they contain anything new. If so, download pack file and
      store or unpack. In either case, note that we have seen the
      pack file in question (I've used $GIT_DIR/checked_packs).

    o Then
        o if http: do the git-http-pull stuff, and we're done

        o if rsync: get a list of all object files in the
          repository, and download the ones we're still missing.

Feel free to take a look, and use anything that might be useful (if 
anything...)

I'm not claiming that this method is better than your way; the only main 
differences are the caching of seen index files, and that I download 
packs first.

My way is faster if the repository contains overlapping object files and 
packs. And doesn't require any new infrastructure.

On the other hand, my method risks fetching too many objects, if a pack 
file solely contains stuff from a branch we don't want. And it requires 
the git-repack-script naming convention to be used on the remote side.

/dan

--------------030307050809040908090207
Content-Type: text/plain;
 name="git-dumb-fetch.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-dumb-fetch.patch.txt"

diff --git a/cat-file.c b/cat-file.c
--- a/cat-file.c
+++ b/cat-file.c
@@ -11,6 +11,42 @@ int main(int argc, char **argv)
 	char type[20];
 	void *buf;
 	unsigned long size;
+	int obj_count = 0;
+	int missing_count = 0;
+	char line[1000];
+
+	if (argc == 2 && !strcmp("--count", argv[1])) {
+		while (fgets(line, sizeof(line), stdin)) {
+			if (get_sha1(line, sha1))
+				die("invalid id %s", line);
+			if (has_sha1_file(sha1))
+				++obj_count;
+			else
+				++missing_count;
+		}
+		printf("%i %i\n", obj_count, missing_count);
+		return 0;
+	}
+
+	if (argc == 2 && !strcmp("--existing", argv[1])) {
+		while (fgets(line, sizeof(line), stdin)) {
+			if (get_sha1(line, sha1))
+				die("invalid id %s", line);
+			if (has_sha1_file(sha1))
+				printf ("%s", line);
+		}
+		return 0;
+	}
+
+	if (argc == 2 && !strcmp("--missing", argv[1])) {
+		while (fgets(line, sizeof(line), stdin)) {
+			if (get_sha1(line, sha1))
+				die("invalid id %s", line);
+			if (!has_sha1_file(sha1))
+				printf ("%s", line);
+		}
+		return 0;
+	}
 
 	if (argc != 3 || get_sha1(argv[2], sha1))
 		usage("git-cat-file [-t | -s | tagname] <sha1>");
diff --git a/git-dumb-fetch b/git-dumb-fetch
new file mode 100755
--- /dev/null
+++ b/git-dumb-fetch
@@ -0,0 +1,182 @@
+#! /bin/sh
+
+# git-dumb-fetch pulls objects from (optionally) packed remote
+# git repositories. 
+
+. git-sh-setup-script || die "Not a git archive"
+
+checked_packs=$GIT_DIR/checked_packs
+
+usage() {
+	die "usage: git-dumb-fetch [-w ref] commit-id url"
+}
+
+http_download() {
+	tmpf=$(basename "$1")
+	wget -O "$tmpd/$tmpf" "$1"
+}
+
+http_cat() {
+	wget -q -O - "$1"
+}
+
+http_list_packs() {
+	# XXX: It would be nice to be able to differentiate between failed
+	# connections and missing pack dir. For now, assume the latter.
+	pindex=$(http_cat "$1/objects/pack/") || return 0 
+		# die "error getting $1"
+	echo "$pindex" | 
+		sed -n 's,.*pack-\([0-9a-f]\{40\}\)\.idx.*,\1\n,gp' |
+		sed '/^$/d' | sort | uniq
+}
+
+http_pull() {
+	git-http-pull -v -a "$1" "$2/"
+}
+
+rsync_download() {
+	rsync "$1" "$tmpd/" > /dev/null
+}
+
+rsync_cat() {
+	tmpf=$(basename "$1")
+	rsync_download "$1" && cat "$tmpd/$tmpf"
+}
+
+rsync_list_packs() {
+	# list every file on the remote side. we'll use that later
+	echo "Listing remote objects" >&2
+	rsync -zr "$1/objects/" > "$tmpd/files" &&
+	LANG=C sed -n 's,.*pack/pack-\([0-9a-f]\{40\}\)\.idx.*,\1,p' < \
+		"$tmpd/files" 
+}
+
+rsync_pull() {
+	LANG=C sed -n 's,.*\([0-9a-f][0-9a-f]\)/\([0-9a-f]\{38\}\).*,\1\2,p' \
+		< "$tmpd/files" | 
+		git-cat-file --missing > "$tmpd/missing" &&
+	LANG=C sed 's,^..,\0/,' < "$tmpd/missing" > "$tmpd/tofetch" || exit 1
+
+	[ -s "$tmpd/tofetch" ] || { echo "Nothing new to fetch" >&2; return; }
+
+	if rsync --help 2>&1 | grep -q files-from; then
+		rsync -avz --ignore-existing --whole-file \
+			--files-from="$tmpd/tofetch" \
+			"$2/objects/" "$GIT_OBJECT_DIRECTORY/" >&2
+	else
+		LANG=C sed -n \
+			's,.*\([0-9a-f][0-9a-f]\)/\([0-9a-f]\{38\}\).*,\1\2,p' \
+			< "$tmpd/files" | 
+			git-cat-file --existing > "$tmpd/got" && 
+		LANG=C sed 's,^..,\0/,' < "$tmpd/got" > "$tmpd/excl" || exit 1
+		if [ -f "$checked_packs" ]; then
+			sed 's,^.*,pack/pack-&.idx,' < "$checked_packs"
+			sed 's,^.*,pack/pack-&.pack,' < "$checked_packs"
+		fi >> "$tmpd/excl"
+		rsync -avz --ignore-existing --whole-file \
+			--exclude-from="$tmpd/excl" \
+			"$2/objects/" "$GIT_OBJECT_DIRECTORY/" >&2
+	fi
+}
+
+idx_policy() {
+	# existing=$1 missing=$2
+	if [ $1 -eq 0 -a $2 -eq 0 ]; then
+		echo empty
+	elif [ $2 -eq 0 ]; then
+		echo all
+	elif [ $1 -eq 0 ]; then
+		echo none
+	else
+		if [ $2 -gt 5000 -a $1 -lt $2 ]; then
+			# It's a really big pack. Don't unpack
+			echo all
+		else
+			echo partial
+		fi
+	fi
+}
+
+check_idx() {
+	counts=$(git-show-index | cut -d' ' -f2 | git-cat-file --count) || 
+		exit 1
+	idx_policy $counts
+}
+
+has_pack() {
+	[ -f "$GIT_OBJECT_DIRECTORY/pack/pack-$1.idx" -a \
+		"$GIT_OBJECT_DIRECTORY/pack/pack-$1.pack" ] && return 0
+	[ -f "$checked_packs" ] && grep -q $1 < "$checked_packs"
+}
+
+fetch_packs() {
+	idx=$($list_packs "$1") || exit 1
+	[ "$idx" ] || return 0
+	echo "Examining remote packs: $idx" >&2
+	for i in $idx; do
+		has_pack $i && continue
+		echo "Downloading pack $i" >&2
+		$download "$1/objects/pack/pack-$i.idx" &&
+		gotit=$(check_idx < "$tmpd/pack-$i.idx") || exit 1
+
+		case $gotit in 
+			partial | none)
+			$download "$1/objects/pack/pack-$i.pack" &&
+			git-verify-pack "$tmpd/pack-$i" || die "invalid pack" ;;
+			*)
+			echo "Already got all objects in pack $i" >&2 ;;
+		esac
+
+		case $gotit in 
+		partial)
+			git-unpack-objects < "$tmpd/pack-$i.pack" || exit 1 ;;
+		none)
+			mv "$tmpd/pack-$i.idx" "$tmpd/pack-$i.pack" \
+				"$GIT_OBJECT_DIRECTORY/pack/" 2>/dev/null ||
+			cp "$tmpd/pack-$i.idx" "$tmpd/pack-$i.pack" \
+				"$GIT_OBJECT_DIRECTORY/pack/" || exit 1 ;;
+		esac
+		echo $i >> "$checked_packs"
+	done
+}
+
+
+while true; do
+	case $1 in
+		--) shift; break ;;
+		-*) die "unknown option: $1" ;;
+		*) break ;;
+	esac
+	shift
+done
+
+url=$1 srchead=$2 
+[ -n "$srchead" -a -n "$url" ] || usage
+
+case $url in
+	http://*) proto=http ;;
+	rsync://*) proto=rsync ;;
+	*) die "don't know how to fetch from $url" ;;
+esac
+
+download=${proto}_download
+cat=${proto}_cat
+list_packs=${proto}_list_packs
+pull=${proto}_pull
+
+tmpd=$(mktemp -d "${TMPDIR:-/tmp}/dumbfetch.XXXXXX") || exit 1
+trap "rm -rf '$tmpd'" 0 1 2 3 15
+
+echo "Fetching from $url" >&2
+remoteid=$($cat "$url/refs/$srchead") || die "error reading $srchead"
+
+if [ "$previd" = "$remoteid" ]; then
+	echo "Up to date" >&2
+	exit 0
+fi
+
+fetch_packs "$url" &&
+$pull "$remoteid" "$url" || die "fetch failed"
+
+echo $remoteid
+

--------------030307050809040908090207--
