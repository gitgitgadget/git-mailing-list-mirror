From: Johan Herland <johan@herland.net>
Subject: [PATCH 01/15] git-note: Add git-note command for
 adding/listing/deleting git notes
Date: Sun, 27 May 2007 16:09:32 +0200
Message-ID: <200705271609.33033.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <alpine.LFD.0.98.0705101116480.3986@woody.linux-foundation.org>
 <200705271608.02122.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 16:09:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsJRS-0006ZH-Hr
	for gcvg-git@gmane.org; Sun, 27 May 2007 16:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbXE0OJt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 10:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752774AbXE0OJt
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 10:09:49 -0400
Received: from smtp.getmail.no ([84.208.20.33]:61033 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752721AbXE0OJs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 10:09:48 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIP0040TE09R000@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:09:45 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP00GP2DZXR040@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:09:33 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP0007LDZXJ750@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:09:33 +0200 (CEST)
In-reply-to: <200705271608.02122.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48541>

Synopsis:
'git-note' [-m <msg> | -F <file>] [<head>]
'git-note' -l [<name>...]
'git-note' -d <name>...

'git-note' without any parameters creates 'note' associated with HEAD.
Specifying an object name/ref to 'git-note' will cause the note to
be associated with that object instead.

`git-note -l [<name>...]` lists notes associated with the given <name>s.
If no <name> is given, all notes are listed. The given <name> may itself
be a note object, in which case it is listed along with its associated
notes (if any).

`git-note -d <name>...` deletes the notes associated with the given
<name>s. The given <name> may itself be a note object, in which case it is
deleted along with its associated notes (if any).

git-note.sh is partly based on git-tag.sh

Signed-off-by: Johan Herland <johan@herland.net>
---
 git-note.sh |  227 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 227 insertions(+), 0 deletions(-)
 create mode 100755 git-note.sh

diff --git a/git-note.sh b/git-note.sh
new file mode 100755
index 0000000..4f539e2
--- /dev/null
+++ b/git-note.sh
@@ -0,0 +1,227 @@
+#!/bin/sh
+
+USAGE='-l [<name>...] | -d <name>... | [-m <msg> | -F <file>] [<head>]'
+LONG_USAGE='Add, delete and show git object notes
+	-l	list/show notes associated with the given object.
+	-d	delete the notes associated with the given object.
+	-m	use the given note message (instead of prompting).
+	-F 	Take the note message from the given file (instead of prompting).
+For -l and -d, the given <name> may be a note object itself, in which case
+it will be included in the listing/deletion.
+When <head> is not given, it defaults to HEAD.'
+SUBDIRECTORY_OK='Yes'
+. git-sh-setup
+
+
+# Show the note identified by $1
+show_note () {
+	authordate=$(git-cat-file -p $1 | grep -m1 '^tagger ' | cut -c8-)
+	echo
+	echo "--- by $authordate"
+	git-cat-file -p $1 | tail -n+6
+	return 0
+}
+
+# Show notes below the refs/notes directory given in $1
+show_notes_below_dir () {
+	prev_object=
+	for note_data in $(git-for-each-ref --shell \
+			--sort=-taggerdate --sort=*authordate \
+			--format='note=%(objectname);object=%(*objectname);object_type=%(*objecttype);object_tag=%(*tag);' \
+			$1)
+	do
+		eval "$note_data"
+
+		# Separate note objects from regular tags
+		if test "$object_type" = "tag" -a -n "$(echo "$object_tag" | grep '^note-')"; then
+			object_type="note"
+			object_tag=""
+		fi
+
+		description=
+		# Create description based on object type
+		case "$object_type" in
+		commit)
+			description="$(git-show --pretty='format:%h (%s) by %an <%ae> on %aD' $object | head -n1)"
+			;;
+		tag)
+			description="$object ($object_tag)"
+			;;
+		*)
+			description="$object"
+			;;
+		esac
+
+		if test "$object" != "$prev_object"; then
+			test -z "$prev_object" || echo
+			echo "=== Notes on $object_type $description"
+		fi
+		show_note $note
+		prev_object="$object"
+	done
+	return 0
+}
+
+# Show the notes associated with the objects in $@
+show_associated_notes () {
+	if test "$#" = "0"; then
+		show_notes_below_dir "refs/notes"
+		return 0
+	fi
+
+	while case "$#" in 0) break ;; esac
+	do
+		obj=$(git-rev-parse --verify "$1") || \
+				die "error: failed to find object named '$1'"
+
+		# If $obj is a note itself, handle it first
+		if test "$(git-cat-file -t $obj)" = "tag"; then
+			if test -n "$(git-cat-file -p $obj | grep '^tag note-')"; then
+				echo
+				echo "=== Note $obj"
+				show_note "$obj"
+			fi
+		fi
+
+		# List all notes associated with $obj.
+		show_notes_below_dir "refs/notes/$obj"
+
+		shift
+	done
+	return 0
+}
+
+# Delete the noteref in $1 pointing to the note identified by the SHA1 in $2
+delete_note () {
+	git-update-ref -m "note: delete" -d "$1" "$2"
+	return 0
+}
+
+# Delete all notes associated with object in $1
+delete_object_notes () {
+	for note_data in $(git-for-each-ref --shell \
+			--sort=taggerdate --sort=*authordate \
+			--format='note=%(objectname);object=%(*objectname);object_type=%(*objecttype);noteref=%(refname)' \
+			refs/notes/$1)
+	do
+		eval "$note_data"
+		echo "Deleting note $note associated with $object_type $object"
+		delete_note "$noteref" "$note"
+	done
+
+	# Try to get rid of $object's directory below refs/notes as well
+	if test -d "$GIT_DIR/refs/notes/$1"; then
+		rmdir "$GIT_DIR/refs/notes/$1"
+	fi
+	return 0
+}
+
+# Delete the notes associated with the objects in $@
+delete_associated_notes () {
+	while case "$#" in 0) break ;; esac
+	do
+		obj=$(git-rev-parse --verify "$1") || \
+				die "error: failed to find object named '$1'"
+
+		# If $obj is a note itself, handle it first
+		if test "$(git-cat-file -t $obj)" = "tag"; then
+			objref="$(git-cat-file -p $obj | grep -m1 '^object ' | cut -c8-)"
+			if test -n "$objref"; then
+				echo "Deleting note $obj"
+				delete_note "refs/notes/$objref/$obj" "$obj"
+			fi
+		fi
+
+		# Delete all notes associated with $obj
+		delete_object_notes "$obj"
+
+		shift
+	done
+	return 0
+}
+
+message_given=
+message=
+while case "$#" in 0) break ;; esac
+do
+	case "$1" in
+	-l)
+		shift
+		show_associated_notes "$@"
+		exit $?
+		;;
+	-d)
+		shift
+		if test "$#" = "0"; then
+			die "error: option -d needs one or more objects"
+		fi
+		delete_associated_notes "$@"
+		exit $?
+		;;
+	-m)
+		shift
+		message="$1"
+		if test "$#" = "0"; then
+			die "error: option -m needs an argument"
+		else
+			message_given=1
+		fi
+		;;
+	-F)
+		shift
+		if test "$#" = "0"; then
+			die "error: option -F needs an argument"
+		else
+			message="$(cat "$1")"
+			message_given=1
+		fi
+		;;
+	-*)
+		usage
+		;;
+	*)
+		break
+		;;
+	esac
+	shift
+done
+
+object=$(git-rev-parse --verify --default HEAD "$@") || exit 1
+type=$(git-cat-file -t $object) || exit 1
+tagger=$(git-var GIT_COMMITTER_IDENT) || exit 1
+
+# Process note message
+trap 'rm -f "$GIT_DIR"/NOTE_TMP* "$GIT_DIR"/NOTE_FINALMSG "$GIT_DIR"/NOTE_EDITMSG' 0
+
+if test -z "$message_given"; then
+	( echo ""
+	  echo "#"
+	  echo "# Write a note on $type $object"
+	  echo "#" ) > "$GIT_DIR/NOTE_EDITMSG"
+	${VISUAL:-${EDITOR:-vi}} "$GIT_DIR/NOTE_EDITMSG" || exit
+else
+	printf '%s\n' "$message" >"$GIT_DIR/NOTE_EDITMSG"
+fi
+
+grep -v '^#' <"$GIT_DIR/NOTE_EDITMSG" |
+git-stripspace >"$GIT_DIR/NOTE_FINALMSG"
+
+test -s "$GIT_DIR/NOTE_FINALMSG" -o -n "$message_given" || {
+	echo >&2 "No note?"
+	exit 1
+}
+
+name="note-`( printf 'object %s\ntagger %s\n\n' "$tagger"; \
+              cat "$GIT_DIR/NOTE_FINALMSG" ) \
+            | sha1sum | cut -d" " -f1`"
+
+git-check-ref-format "notes/$object/$name" ||
+	die "Failed to create a valid note name. (internal git-note error)"
+
+( printf 'object %s\ntype %s\ntag %s\ntagger %s\n\n' \
+		"$object"  "$type"  "$name" "$tagger";
+		cat "$GIT_DIR/NOTE_FINALMSG" ) >"$GIT_DIR/NOTE_TMP"
+rm -f "$GIT_DIR/NOTE_FINALMSG"
+note=$(git-mktag < "$GIT_DIR/NOTE_TMP")
+
+git-update-ref "refs/notes/$object/$note" "$note"
-- 
1.5.2.101.gee49f
