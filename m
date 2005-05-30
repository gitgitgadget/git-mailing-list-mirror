From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: I want to release a "git-1.0"
Date: Mon, 30 May 2005 17:55:14 -0500
Message-ID: <200505301755.15371.dtor_core@ameritech.net>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org> <20050530221214.GA29556@redhat.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Tn5mCL+WJtTw2+u"
Cc: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 31 00:57:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DctCH-0000g4-HS
	for gcvg-git@gmane.org; Tue, 31 May 2005 00:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVE3W7R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 18:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVE3W6O
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 18:58:14 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:45987 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261581AbVE3Wza (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 18:55:30 -0400
Received: from unknown (HELO mail.corenet.homeip.net) (dtor?core@ameritech.net@68.21.93.207 with login)
  by smtp803.mail.sc5.yahoo.com with SMTP; 30 May 2005 22:55:19 -0000
To: git@vger.kernel.org
User-Agent: KMail/1.8
In-Reply-To: <20050530221214.GA29556@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--Boundary-00=_Tn5mCL+WJtTw2+u
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 30 May 2005 17:12, Dave Jones wrote:
> I realise you've got a nifty bunch of tools to apply a whole mbox of
> patches, but that's not ideal if all of my patches aren't in mboxes
> (some I create myself and toss in my spool, some I pull from bugzilla etc..)

I mercilessly hacked Linus's scripts from git-tools repo to work with
non-mailbox patches, maybe you can make use of them too. Note that
stripspace.c is not changed in any way whatsoever and mailsplit.c was
changed to handle my personal preference of having patch description
in the form of:

Input: make blah blah change
---
 
And Linus's script would eat that line.

-- 
Dmitry

--Boundary-00=_Tn5mCL+WJtTw2+u
Content-Type: application/x-shellscript;
  name="applypatch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="applypatch"

#!/bin/sh
##
## "dotest" is my stupid name for my patch-application script, which
## I never got around to renaming after I tested it. We're now on the
## second generation of scripts, still called "dotest".
##
## You give it a mbox-format collection of emails, and it will try to
## apply them to the kernel using "applypatch"
##
## applypatch [ -i ] patch1 [patch2...]
##

WORKDIR=`mktemp -d` || exit 1

case $1 in

	-i)	touch $WORKDIR/.confirm_apply
		shift;;
esac

#mailsplit $1 $WORKDIR || exit 1

for i in "$@"
do
	mailinfo $WORKDIR/msg $WORKDIR/patch $WORKDIR/files < $i > $WORKDIR/info || exit 1
	stripspace < $WORKDIR/msg > $WORKDIR/msg-clean
	~/lib/apply_parsed_patch $WORKDIR
	ret=$?
	if [ $ret -ne 0 ]; then
		# 2 is a special exit code from applypatch to indicate that
		# the patch wasn't applied, but continue anyway
		[ $ret -ne 2 ] && exit $ret
	fi
done

rm -fr $WORKDIR

--Boundary-00=_Tn5mCL+WJtTw2+u
Content-Type: application/x-shellscript;
  name="apply_parsed_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="apply_parsed_patch"

#!/bin/sh
##
## apply_parsed_patch takes four files and uses those to apply the
## unpacked patch that they represent to the current tree.
##
## The arguments are:
##	$1 - working directory
##
final=$1/final-commit
confirm_apply=$1/.confirm_apply
MSGFILE=$1/msg-clean
PATCHFILE=$1/patch
FILES=$1/files
INFO=$1/info
EDIT=${VISUAL:-$EDITOR}
EDIT=${EDIT:-vi}

export GIT_AUTHOR_NAME="$(sed -n '/^Author/ s/Author: //p' $INFO)"
export GIT_AUTHOR_EMAIL="$(sed -n '/^Email/ s/Email: //p' $INFO)"
export GIT_AUTHOR_DATE="$(sed -n '/^Date/ s/Date: //p' $INFO)"
export SUBJECT="$(sed -n '/^Subject/ s/Subject: //p' $INFO)"
[ -z "$SUBJECT" ] && SUBJECT="$(head -n1 $MSGFILE)"
[ -z "$GIT_AUTHOR_NAME" ] && GIT_AUTHOR_NAME="$GIT_COMMITTER_NAME"
[ -z "$GIT_AUTHOR_EMAIL" ] && GIT_AUTHOR_EMAIL="$GIT_COMMITTER_EMAIL"

awk "
	BEGIN { have_signoff = 0 }
	(/^Signed-off-by: +${SIGNOFF_STRING}$/) { have_signoff = 1 }
	{ print }
	END { if (!have_signoff) print \"Signed-off-by: ${SIGNOFF_STRING}\n\" }
" $MSGFILE > $final

doit=0
[ -f $confirm_apply ] || doit=1

while [ $doit -eq 0 ]; do
	echo "From: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>"
	echo "By: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
	echo "Commit Body is:"
	echo "--------------------------"
	cat $final
	echo "--------------------------"
	echo -n "Apply? [y]es/[n]o/[e]dit/[a]ccept all "
	read reply
	case $reply in
		y|Y) doit=1;;
		n|N) GIT_AUTHOR_NAME="$GIT_COMMITTER_NAME"
		     GIT_AUTHOR_EMAIL="$GIT_COMMITTER_EMAIL"
		     exit 2;;	# special value to tell dotest to keep going
		e|E) $EDIT $final;;
		a|A) rm -f $confirm_apply
		     doit=1;;
	esac
done

echo
echo Applying "'$SUBJECT'"
echo

git-check-files $(cat $FILES) || exit 1
git-checkout-cache -q $(cat $FILES) || exit 1
patch -E -u --no-backup-if-mismatch -f -p1 --fuzz=0 --input=$PATCHFILE || exit 1
git-update-cache --add --remove $(cat $FILES) || exit 1
tree=$(git-write-tree) || exit 1
echo Wrote tree $tree
commit=$(git-commit-tree $tree -p $(cat .git/HEAD) < $final) || exit 1
echo Committed: $commit
echo $commit > .git/HEAD

GIT_AUTHOR_NAME="$GIT_COMMITTER_NAME"
GIT_AUTHOR_EMAIL="$GIT_COMMITTER_EMAIL"

--Boundary-00=_Tn5mCL+WJtTw2+u
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="stripspace.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="stripspace.c"

#include <stdio.h>
#include <string.h>
#include <ctype.h>

/*
 * Remove empty lines from the beginning and end.
 *
 * Turn multiple consecutive empty lines into just one
 * empty line.
 */
static void cleanup(char *line)
{
	int len = strlen(line);

	if (len > 1 && line[len-1] == '\n') {
		do {
			unsigned char c = line[len-2];
			if (!isspace(c))
				break;
			line[len-2] = '\n';
			len--;
			line[len] = 0;
		} while (len > 1);
	}
}

int main(int argc, char **argv)
{
	int empties = -1;
	char line[1024];

	while (fgets(line, sizeof(line), stdin)) {
		cleanup(line);

		/* Not just an empty line? */
		if (line[0] != '\n') {
			if (empties > 0)
				putchar('\n');
			empties = 0;
			fputs(line, stdout);
			continue;
		}
		if (empties < 0)
			continue;
		empties++;
	}
	return 0;
}

--Boundary-00=_Tn5mCL+WJtTw2+u
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="mailsplit.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mailsplit.c"

/*
 * Totally braindamaged mbox splitter program.
 *
 * It just splits a mbox into a list of files: "0001" "0002" ..
 * so you can process them further from there.
 */
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <string.h>
#include <stdio.h>
#include <ctype.h>
#include <assert.h>

static int usage(void)
{
	fprintf(stderr, "mailsplit <mbox> <directory>\n");
	exit(1);
}

static int linelen(const char *map, unsigned long size)
{
	int len = 0, c;

	do {
		c = *map;
		map++;
		size--;
		len++;
	} while (size && c != '\n');
	return len;
}

static int is_from_line(const char *line, int len)
{
	const char *colon;

	if (len < 20 || memcmp("From ", line, 5))
		return 0;

	colon = line + len - 2;
	line += 5;
	for (;;) {
		if (colon < line)
			return 0;
		if (*--colon == ':')
			break;
	}

	if (!isdigit(colon[-4]) ||
	    !isdigit(colon[-2]) ||
	    !isdigit(colon[-1]) ||
	    !isdigit(colon[ 1]) ||
	    !isdigit(colon[ 2]))
		return 0;

	/* year */
	if (strtol(colon+3, NULL, 10) <= 90)
		return 0;

	/* Ok, close enough */
	return 1;
}

static int parse_email(const void *map, unsigned long size)
{
	unsigned long offset;

	if (size < 6 || memcmp("From ", map, 5))
		goto corrupt;

	/* Make sure we don't trigger on this first line */
	map++; size--; offset=1;

	/*
	 * Search for a line beginning with "From ", and 
	 * having smething that looks like a date format.
	 */
	do {
		int len = linelen(map, size);
		if (is_from_line(map, len))
			return offset;
		map += len;
		size -= len;
		offset += len;
	} while (size);
	return offset;

corrupt:
	fprintf(stderr, "corrupt mailbox\n");
	exit(1);
}

int main(int argc, char **argv)
{
	int fd, nr;
	struct stat st;
	unsigned long size;
	void *map;

	if (argc != 3)
		usage();
	fd = open(argv[1], O_RDONLY);
	if (fd < 0) {
		perror(argv[1]);
		exit(1);
	}
	if (chdir(argv[2]) < 0)
		usage();
	if (fstat(fd, &st) < 0) {
		perror("stat");
		exit(1);
	}
	size = st.st_size;
	map = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
	if (-1 == (int)(long)map) {
		perror("mmap");
		exit(1);
	}
	close(fd);
	nr = 0;
	do {
		char name[10];
		unsigned long len = parse_email(map, size);
		assert(len <= size);
		sprintf(name, "%04d", ++nr);
		fd = open(name, O_WRONLY | O_CREAT | O_EXCL, 0600);
		if (fd < 0) {
			perror(name);
			exit(1);
		}
		if (write(fd, map, len) != len) {
			perror("write");
			exit(1);
		}
		close(fd);
		map += len;
		size -= len;
	} while (size > 0);
	return 0;
}

--Boundary-00=_Tn5mCL+WJtTw2+u--
