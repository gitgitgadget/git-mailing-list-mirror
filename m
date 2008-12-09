From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: git-bpush: Pushing to a bundle
Date: Tue, 9 Dec 2008 10:49:14 +0100
Message-ID: <adf1fd3d0812090149m158fcb9as15bacce58c61a1a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_67570_25153944.1228816154629"
To: "git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 09 10:50:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9zEh-0002l1-PO
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 10:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbYLIJtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 04:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752535AbYLIJtS
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 04:49:18 -0500
Received: from gv-out-0910.google.com ([216.239.58.185]:61910 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbYLIJtR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 04:49:17 -0500
Received: by gv-out-0910.google.com with SMTP id e6so363041gvc.37
        for <git@vger.kernel.org>; Tue, 09 Dec 2008 01:49:15 -0800 (PST)
Received: by 10.103.244.4 with SMTP id w4mr1634562mur.11.1228816154622;
        Tue, 09 Dec 2008 01:49:14 -0800 (PST)
Received: by 10.103.167.6 with HTTP; Tue, 9 Dec 2008 01:49:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102616>

------=_Part_67570_25153944.1228816154629
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi *,

  I've made a script to push to a bundle that tries to behave as the
normal push.

  It has some limitations, but for the normal cases it works fine.

The basic idea is:

- Easily create bundles with the current branch.
- Be able to push to defined bundles in remote.<remote>.url
- Only add new objects by default (do not lose objects)
- Reuse existing bundles (keep the basis and the branches)
- Check that the branches fast-forward
- Keep the pushed branches in refs/remotes/<remote>/*

But it also has some limitations:

- Do not allow refspec (git-bundle do not support them), only branch/tags names.
- Push all branches or none (consequence of the above)
- ...

Hope this helps,
Santi

The scripts follows, but also attatched.
#!/bin/sh

OPTIONS_KEEPDASHDASH=
OPTIONS_SPEC="\
git bpush [options] [<remote> [<refs>...]]
--
f,force   force updates
full      create a full bundle
v         be verbose
"
SUBDIRECTORY_OK=Yes
. git-sh-setup
. git-parse-remote

cd_to_toplevel

LF='
'
IFS="$LF"

bases=
bbases=
changed=
force=
nonff=
remote=
refs=
while [ $# != 0 ] ; do
    case "$1" in
	-v) verbose=t;;
	--full) full=t;;
	-f|--force) force=t;;
	--) shift; break;;
	*) usage;;
    esac
    shift
done

[ -n "$1" ] && remote=$1 && shift
while [ $# != 0 ] ; do
    refs="$refs$LF$1" && shift
done

[ -z "$remote" ] && remote=$(get_default_remote)
remoteurl=$(git config remote.${remote}.url)
[ -z "$remoteurl" ] && remoteurl=$remote
[ -d "$remoteurl" ] && die "$remoteurl is a directory"

# Default bases in bundle.base
# Default {refs,base} can be specified in remote.<remote>.{push,bundlebase}
if [ "$remote" != "$remoteurl" ] ; then
    [ -z "$refs" ] &&
    refs=$(git config --get-all remote.${remote}.push)
    bases=$(git config --get-all remote.${remote}.bundlebase ||
	git config --get-all bundle.base)
else
    bases=$(git config --get-all bundle.base)
fi

# git rev-parse --symbolic-full-name resolves symlinks
# Keep at least HEAD
head=
for ref in $refs ; do
    [ "$ref" = HEAD ] && head=t && break
done

[ -n "$bases" ] && bases=$(git rev-parse --revs-only $bases | sort -u)
# Full symbolic refs to be uniq
[ -n "$refs" ] && \
    refs=$(git-rev-parse --symbolic-full-name --revs-only $refs | sort -u) && \
    [ -n "$head" ] && refs="HEAD$LF$refs"

if [ -e "$remoteurl" ] ; then
    # Find the bundle's bases
    refs="$refs$LF$(git bundle list-heads $remoteurl | cut -d " " -f 2)"
    requires=
    for line in $(git bundle verify "$remoteurl" 2>/dev/null) ; do
	case "$line" in "The bundle requires"*) requires=t && continue; esac
	[ -z "$requires" ] && continue
	bbase=$(echo $line | cut -d " " -f 1)
	[ -z "$bbases" ] && bbases=$bbase && continue
	bbases="$bbases$LF$bbase"
    done
    bbases=$(echo "$bbases" | sort -u)
    [ -z "$bases" ] && bases="$bbases" || bases="$bases$LF$bbases"
elif [ -z "$refs" ] ; then
    # Push current branch
    refs="HEAD$LF$(git symbolic-ref -q HEAD)"
fi

[ -z "$refs" ] && die "No refs to push"

refs=$(echo "$refs" | sort -u)

for ref in $bases $refs ; do
    [ "$(git cat-file -t $ref^{})" != commit ] && \
	die "$(basename $0): $ref is not a commit"
done

header="To $remoteurl"
[ -n "$verbose" ] && echo "Pushing to $remoteurl" && echo $header && header=

# Find what is/is not a fast-forward, up to date or new
# As "git bundle" does not support refspecs we must push all matching branches
for ref in $refs ; do
    case $ref in
	refs/tags/*) type=tags; newtext="new tag";;
	refs/heads/*|HEAD) type=heads ; newtext="new branch" ;;
    esac
    newhash=$(git rev-parse $ref)
    newshort=$(git rev-parse --short $ref)
    bshort=$(echo $ref | sed -e "s|^refs/$type/||")
    if [ -e "$remoteurl" ] ; then
	bheads="$(git bundle list-heads $remoteurl)"
	for bhead in $bheads ; do
	    bhash=$(echo $bhead | cut -d " " -f 1)
	    bref=$(echo $bhead | cut -d " " -f 2)
	    [ "$bref" != "$ref" ] && continue
	    oldshort=$(git-rev-parse --short $bhash)
	    case $type in
		tags)
		    base=$newhash;;
		heads)
		    base=$(git merge-base $bref $bhash);;
	    esac
	    if [ "$base" != $bhash ] ; then
		[ -n "$header" ] && echo $header && header=
		if [ -z "$force" ] ; then
		    nonff=t
		    echo " ! [rejected] $bshort -> $bshort (non-fast forward)"
		else
		    changed=t
		    echo " + $oldshort...$newshort $bshort -> $bshort (forced update)"
		fi
		continue 2
	    fi
	    if [ "$newhash" != "$bhash" ] ; then
		changed=t
		[ -n "$header" ] && echo $header && header=
		echo "   $oldshort..$newshort $bshort -> $bshort"
	    elif [ -n "$verbose" ] ; then
		[ -n "$header" ] && echo $header && header=
		echo " = [up to date] $bshort -> $bshort"
	    fi
	    continue 2
	done
    fi
    [ -n "$header" ] && echo $header && header=
    echo " * [$newtext] $bshort -> $bshort"
    changed=t
done

[ -n "$full" ] && bases= && [ -n "$bbases" ] && changed=t

[ -n "$nonff" ] && die "error: failed to push some refs to $remoteurl"
[ -z "$changed" ] && die "Everything up-to-date"
[ -n "$bases" ] && bases="--not$LF$bases"

git bundle create $remoteurl $refs $bases
[ "$remote" != "$remoteurl" ] && git fetch -q "$remote"
exit 0

------=_Part_67570_25153944.1228816154629
Content-Type: application/octet-stream; name=git-bpush
Content-Transfer-Encoding: base64
X-Attachment-Id: f_foidcya40
Content-Disposition: attachment; filename=git-bpush

IyEvYmluL3NoCgpPUFRJT05TX0tFRVBEQVNIREFTSD0KT1BUSU9OU19TUEVDPSJcCmdpdCBicHVz
aCBbb3B0aW9uc10gWzxyZW1vdGU+IFs8cmVmcz4uLi5dXQotLQpmLGZvcmNlICAgZm9yY2UgdXBk
YXRlcwpmdWxsICAgICAgY3JlYXRlIGEgZnVsbCBidW5kbGUKdiAgICAgICAgIGJlIHZlcmJvc2UK
IgpTVUJESVJFQ1RPUllfT0s9WWVzCi4gZ2l0LXNoLXNldHVwCi4gZ2l0LXBhcnNlLXJlbW90ZQoK
Y2RfdG9fdG9wbGV2ZWwKCkxGPScKJwpJRlM9IiRMRiIKCmJhc2VzPQpiYmFzZXM9CmNoYW5nZWQ9
CmZvcmNlPQpub25mZj0KcmVtb3RlPQpyZWZzPQp3aGlsZSBbICQjICE9IDAgXSA7IGRvCiAgICBj
YXNlICIkMSIgaW4KCS12KSB2ZXJib3NlPXQ7OwoJLS1mdWxsKSBmdWxsPXQ7OwoJLWZ8LS1mb3Jj
ZSkgZm9yY2U9dDs7CgktLSkgc2hpZnQ7IGJyZWFrOzsKCSopIHVzYWdlOzsKICAgIGVzYWMKICAg
IHNoaWZ0CmRvbmUKClsgLW4gIiQxIiBdICYmIHJlbW90ZT0kMSAmJiBzaGlmdAp3aGlsZSBbICQj
ICE9IDAgXSA7IGRvCiAgICByZWZzPSIkcmVmcyRMRiQxIiAmJiBzaGlmdApkb25lCgpbIC16ICIk
cmVtb3RlIiBdICYmIHJlbW90ZT0kKGdldF9kZWZhdWx0X3JlbW90ZSkKcmVtb3RldXJsPSQoZ2l0
IGNvbmZpZyByZW1vdGUuJHtyZW1vdGV9LnVybCkKWyAteiAiJHJlbW90ZXVybCIgXSAmJiByZW1v
dGV1cmw9JHJlbW90ZQpbIC1kICIkcmVtb3RldXJsIiBdICYmIGRpZSAiJHJlbW90ZXVybCBpcyBh
IGRpcmVjdG9yeSIKCiMgRGVmYXVsdCBiYXNlcyBpbiBidW5kbGUuYmFzZQojIERlZmF1bHQge3Jl
ZnMsYmFzZX0gY2FuIGJlIHNwZWNpZmllZCBpbiByZW1vdGUuPHJlbW90ZT4ue3B1c2gsYnVuZGxl
YmFzZX0KaWYgWyAiJHJlbW90ZSIgIT0gIiRyZW1vdGV1cmwiIF0gOyB0aGVuCiAgICBbIC16ICIk
cmVmcyIgXSAmJgogICAgcmVmcz0kKGdpdCBjb25maWcgLS1nZXQtYWxsIHJlbW90ZS4ke3JlbW90
ZX0ucHVzaCkKICAgIGJhc2VzPSQoZ2l0IGNvbmZpZyAtLWdldC1hbGwgcmVtb3RlLiR7cmVtb3Rl
fS5idW5kbGViYXNlIHx8CglnaXQgY29uZmlnIC0tZ2V0LWFsbCBidW5kbGUuYmFzZSkKZWxzZQog
ICAgYmFzZXM9JChnaXQgY29uZmlnIC0tZ2V0LWFsbCBidW5kbGUuYmFzZSkKZmkKCiMgZ2l0IHJl
di1wYXJzZSAtLXN5bWJvbGljLWZ1bGwtbmFtZSByZXNvbHZlcyBzeW1saW5rcwojIEtlZXAgYXQg
bGVhc3QgSEVBRApoZWFkPQpmb3IgcmVmIGluICRyZWZzIDsgZG8KICAgIFsgIiRyZWYiID0gSEVB
RCBdICYmIGhlYWQ9dCAmJiBicmVhawpkb25lCgpbIC1uICIkYmFzZXMiIF0gJiYgYmFzZXM9JChn
aXQgcmV2LXBhcnNlIC0tcmV2cy1vbmx5ICRiYXNlcyB8IHNvcnQgLXUpCiMgRnVsbCBzeW1ib2xp
YyByZWZzIHRvIGJlIHVuaXEKWyAtbiAiJHJlZnMiIF0gJiYgXAogICAgcmVmcz0kKGdpdC1yZXYt
cGFyc2UgLS1zeW1ib2xpYy1mdWxsLW5hbWUgLS1yZXZzLW9ubHkgJHJlZnMgfCBzb3J0IC11KSAm
JiBcCiAgICBbIC1uICIkaGVhZCIgXSAmJiByZWZzPSJIRUFEJExGJHJlZnMiCgppZiBbIC1lICIk
cmVtb3RldXJsIiBdIDsgdGhlbgogICAgIyBGaW5kIHRoZSBidW5kbGUncyBiYXNlcwogICAgcmVm
cz0iJHJlZnMkTEYkKGdpdCBidW5kbGUgbGlzdC1oZWFkcyAkcmVtb3RldXJsIHwgY3V0IC1kICIg
IiAtZiAyKSIKICAgIHJlcXVpcmVzPQogICAgZm9yIGxpbmUgaW4gJChnaXQgYnVuZGxlIHZlcmlm
eSAiJHJlbW90ZXVybCIgMj4vZGV2L251bGwpIDsgZG8KCWNhc2UgIiRsaW5lIiBpbiAiVGhlIGJ1
bmRsZSByZXF1aXJlcyIqKSByZXF1aXJlcz10ICYmIGNvbnRpbnVlOyBlc2FjCglbIC16ICIkcmVx
dWlyZXMiIF0gJiYgY29udGludWUKCWJiYXNlPSQoZWNobyAkbGluZSB8IGN1dCAtZCAiICIgLWYg
MSkKCVsgLXogIiRiYmFzZXMiIF0gJiYgYmJhc2VzPSRiYmFzZSAmJiBjb250aW51ZQoJYmJhc2Vz
PSIkYmJhc2VzJExGJGJiYXNlIgogICAgZG9uZQogICAgYmJhc2VzPSQoZWNobyAiJGJiYXNlcyIg
fCBzb3J0IC11KQogICAgWyAteiAiJGJhc2VzIiBdICYmIGJhc2VzPSIkYmJhc2VzIiB8fCBiYXNl
cz0iJGJhc2VzJExGJGJiYXNlcyIKZWxpZiBbIC16ICIkcmVmcyIgXSA7IHRoZW4KICAgICMgUHVz
aCBjdXJyZW50IGJyYW5jaAogICAgcmVmcz0iSEVBRCRMRiQoZ2l0IHN5bWJvbGljLXJlZiAtcSBI
RUFEKSIKZmkKClsgLXogIiRyZWZzIiBdICYmIGRpZSAiTm8gcmVmcyB0byBwdXNoIgoKcmVmcz0k
KGVjaG8gIiRyZWZzIiB8IHNvcnQgLXUpCgpmb3IgcmVmIGluICRiYXNlcyAkcmVmcyA7IGRvCiAg
ICBbICIkKGdpdCBjYXQtZmlsZSAtdCAkcmVmXnt9KSIgIT0gY29tbWl0IF0gJiYgXAoJZGllICIk
KGJhc2VuYW1lICQwKTogJHJlZiBpcyBub3QgYSBjb21taXQiCmRvbmUKCmhlYWRlcj0iVG8gJHJl
bW90ZXVybCIKWyAtbiAiJHZlcmJvc2UiIF0gJiYgZWNobyAiUHVzaGluZyB0byAkcmVtb3RldXJs
IiAmJiBlY2hvICRoZWFkZXIgJiYgaGVhZGVyPQoKIyBGaW5kIHdoYXQgaXMvaXMgbm90IGEgZmFz
dC1mb3J3YXJkLCB1cCB0byBkYXRlIG9yIG5ldwojIEFzICJnaXQgYnVuZGxlIiBkb2VzIG5vdCBz
dXBwb3J0IHJlZnNwZWNzIHdlIG11c3QgcHVzaCBhbGwgbWF0Y2hpbmcgYnJhbmNoZXMKZm9yIHJl
ZiBpbiAkcmVmcyA7IGRvCiAgICBjYXNlICRyZWYgaW4KCXJlZnMvdGFncy8qKSB0eXBlPXRhZ3M7
IG5ld3RleHQ9Im5ldyB0YWciOzsKCXJlZnMvaGVhZHMvKnxIRUFEKSB0eXBlPWhlYWRzIDsgbmV3
dGV4dD0ibmV3IGJyYW5jaCIgOzsKICAgIGVzYWMKICAgIG5ld2hhc2g9JChnaXQgcmV2LXBhcnNl
ICRyZWYpCiAgICBuZXdzaG9ydD0kKGdpdCByZXYtcGFyc2UgLS1zaG9ydCAkcmVmKQogICAgYnNo
b3J0PSQoZWNobyAkcmVmIHwgc2VkIC1lICJzfF5yZWZzLyR0eXBlL3x8IikKICAgIGlmIFsgLWUg
IiRyZW1vdGV1cmwiIF0gOyB0aGVuCgliaGVhZHM9IiQoZ2l0IGJ1bmRsZSBsaXN0LWhlYWRzICRy
ZW1vdGV1cmwpIgoJZm9yIGJoZWFkIGluICRiaGVhZHMgOyBkbwoJICAgIGJoYXNoPSQoZWNobyAk
YmhlYWQgfCBjdXQgLWQgIiAiIC1mIDEpCgkgICAgYnJlZj0kKGVjaG8gJGJoZWFkIHwgY3V0IC1k
ICIgIiAtZiAyKQoJICAgIFsgIiRicmVmIiAhPSAiJHJlZiIgXSAmJiBjb250aW51ZQoJICAgIG9s
ZHNob3J0PSQoZ2l0LXJldi1wYXJzZSAtLXNob3J0ICRiaGFzaCkKCSAgICBjYXNlICR0eXBlIGlu
CgkJdGFncykKCQkgICAgYmFzZT0kbmV3aGFzaDs7CgkJaGVhZHMpCgkJICAgIGJhc2U9JChnaXQg
bWVyZ2UtYmFzZSAkYnJlZiAkYmhhc2gpOzsKCSAgICBlc2FjCgkgICAgaWYgWyAiJGJhc2UiICE9
ICRiaGFzaCBdIDsgdGhlbgoJCVsgLW4gIiRoZWFkZXIiIF0gJiYgZWNobyAkaGVhZGVyICYmIGhl
YWRlcj0KCQlpZiBbIC16ICIkZm9yY2UiIF0gOyB0aGVuCgkJICAgIG5vbmZmPXQKCQkgICAgZWNo
byAiICEgW3JlamVjdGVkXSAkYnNob3J0IC0+ICRic2hvcnQgKG5vbi1mYXN0IGZvcndhcmQpIgoJ
CWVsc2UKCQkgICAgY2hhbmdlZD10CgkJICAgIGVjaG8gIiArICRvbGRzaG9ydC4uLiRuZXdzaG9y
dCAkYnNob3J0IC0+ICRic2hvcnQgKGZvcmNlZCB1cGRhdGUpIgoJCWZpCgkJY29udGludWUgMgoJ
ICAgIGZpCgkgICAgaWYgWyAiJG5ld2hhc2giICE9ICIkYmhhc2giIF0gOyB0aGVuCgkJY2hhbmdl
ZD10CgkJWyAtbiAiJGhlYWRlciIgXSAmJiBlY2hvICRoZWFkZXIgJiYgaGVhZGVyPQoJCWVjaG8g
IiAgICRvbGRzaG9ydC4uJG5ld3Nob3J0ICRic2hvcnQgLT4gJGJzaG9ydCIKCSAgICBlbGlmIFsg
LW4gIiR2ZXJib3NlIiBdIDsgdGhlbgoJCVsgLW4gIiRoZWFkZXIiIF0gJiYgZWNobyAkaGVhZGVy
ICYmIGhlYWRlcj0KCQllY2hvICIgPSBbdXAgdG8gZGF0ZV0gJGJzaG9ydCAtPiAkYnNob3J0IgoJ
ICAgIGZpCgkgICAgY29udGludWUgMgoJZG9uZQogICAgZmkKICAgIFsgLW4gIiRoZWFkZXIiIF0g
JiYgZWNobyAkaGVhZGVyICYmIGhlYWRlcj0KICAgIGVjaG8gIiAqIFskbmV3dGV4dF0gJGJzaG9y
dCAtPiAkYnNob3J0IgogICAgY2hhbmdlZD10CmRvbmUKClsgLW4gIiRmdWxsIiBdICYmIGJhc2Vz
PSAmJiBbIC1uICIkYmJhc2VzIiBdICYmIGNoYW5nZWQ9dAoKWyAtbiAiJG5vbmZmIiBdICYmIGRp
ZSAiZXJyb3I6IGZhaWxlZCB0byBwdXNoIHNvbWUgcmVmcyB0byAkcmVtb3RldXJsIgpbIC16ICIk
Y2hhbmdlZCIgXSAmJiBkaWUgIkV2ZXJ5dGhpbmcgdXAtdG8tZGF0ZSIKWyAtbiAiJGJhc2VzIiBd
ICYmIGJhc2VzPSItLW5vdCRMRiRiYXNlcyIKCmdpdCBidW5kbGUgY3JlYXRlICRyZW1vdGV1cmwg
JHJlZnMgJGJhc2VzClsgIiRyZW1vdGUiICE9ICIkcmVtb3RldXJsIiBdICYmIGdpdCBmZXRjaCAt
cSAiJHJlbW90ZSIKZXhpdCAwCg==
------=_Part_67570_25153944.1228816154629--
