From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] generate-cmdlist.sh: parse common group commands
Date: Thu, 7 May 2015 23:20:11 -0400
Message-ID: <20150508032011.GA10209@flurp.local>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
 <a787babf25481c99edea6dca5e5f7814601395fe.1430770308.git.sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?iso-8859-1?Q?S=E9bastien?= Guimmara 
	<sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 05:23:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqYsk-0002ZT-K5
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 05:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbbEHDUU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 May 2015 23:20:20 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35485 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbbEHDUR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 23:20:17 -0400
Received: by igbyr2 with SMTP id yr2so10854640igb.0
        for <git@vger.kernel.org>; Thu, 07 May 2015 20:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JPPrBNIp0wmqcSa+0oKu/9tFo86wQDet/UmNrPuoVKU=;
        b=ozUAV9qhre5t3dIAQUP0bE+7kExnKU4IxMKWj7OIdxON6QllGS0+AlHuPibGid0jMg
         hhlXxq3C3osV/6vWX6caLIqpaHXoCEbLyuhfrPayBY8+wz2Bl8FV2IsLcCVH0x2iLOUA
         w/cK2R0HybH3x9hFghCYcE+WMJUKPrwU1kAv3YXnb4QJG9uwnxMtT3iDr7Vu32ralF5W
         PxGic8ltwmI8YMG/HoUMpvNbaQtZERUOt5Pj9bsDRjyzVLE9lS6BuFMbfIcDdGWy443H
         7zIKdQLdmZW2UXLU79NpA6uR+aRIdenv+ZX8J9Sar3KxtX+j0iQ5U4+849K+/lQBnLCE
         LhBQ==
X-Received: by 10.107.5.210 with SMTP id 201mr2286017iof.57.1431055216995;
        Thu, 07 May 2015 20:20:16 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id qo11sm2940270igb.17.2015.05.07.20.20.16
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 07 May 2015 20:20:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <a787babf25481c99edea6dca5e5f7814601395fe.1430770308.git.sebastien.guimmara@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268598>

On Mon, May 04, 2015 at 10:28:09PM +0200, S=E9bastien Guimmara wrote:
> parse the [groups] block to create the array of group descriptions
>=20
>    static char *common_cmd_groups[] =3D {
>       N_("starting a working area"),
>       ...
>    };
>=20
> then map each element of common_cmds[] to a group via its index:
>=20
>    static struct cmdname_help common_cmds[] =3D {
>      {"add", N_("Add file contents to the index"), 1},
>      ...
>=20
> So that 'git help' can print those command grouped by theme.
> ---
> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> @@ -1,23 +1,42 @@
> +content=3D$(cat command-list.txt)
> +
> +group_line_no=3D$(expr $(echo "$content" | grep -n '^\[groups\]' | c=
ut -f1 -d:) + 1)
> +command_line_no=3D$(expr $(echo "$content" | grep -n '^\[commands\]'=
 | cut -f1 -d:) + 1)
> +groups=3D$(echo "$content" | sed -n ''$group_line_no', '$(expr $comm=
and_line_no)'p')
> [...]
> +static char *common_cmd_groups[] =3D {"
> +echo "$groups" |
> +while read group description; do
> +    if [ -z $group ]; then
> +        break
> +    fi
> +    echo '   N_("'$description'"),'
> +done
> +echo "};
> [...]
> +echo "$content" | grep 'common-' |
> +awk '{ print $1, "\t", $3 }' |
> +while read cmd grp; do
> +    cmd_name=3D$(echo $cmd | cut -d - -f 2)
> +    group_name=3D$(echo $grp | cut -d - -f 2)
> +    group_idx=3D$(expr $(echo "$groups" | grep -n "^$group_name" | c=
ut -c 1) - 1)
> +    sed -n '
> +    /^NAME/,/git-'"$cmd_name"'/H
> +    ${
> +       x
> +       s/.*git-'"$cmd_name"' - \(.*\)/  {"'"$cmd_name"'", N_("\1"), =
'"$group_idx"'},/
> +       p
> +    }' "Documentation/$cmd.txt"

Background: In an earlier review, I observed[1] that the "common-" in
the "common-N_group" form was redundant, and I suggested that you
could add a [groups] section listing the groups, and that the order
of items in [groups] would imply the "git help" display order of the
groups, thus allowing you to do away with the "N_" qualifier, as
well. I also observed that you could determine if a command in
[commands] was common by checking if it was tagged with an attribute
from [groups], thus alleviating the need for the "common-" prefix.

This round makes nice headway toward the proposed scheme, although it
still depends upon the redundant "common-" prefix. When I earlier
suggested that awk could be helpful[2], I was thinking of its
associative arrays which could be used to determine if a command in
[commands] was tagged with an attribute from [groups].

I had intended to reply to the current patch with a short "here's
what I had in mind" example of using awk to achieve this goal,
however, the short example ended up implementing the full
functionality, so I went ahead and turned it into a proper patch[6]
(below), and shamelessly re-used your commit message (with minor
changes). You're welcome to include this patch in your re-roll, or
use it as inspiration if you want to write the functionality
yourself.

Some notes about the re-implementation in awk: It assumes that
[groups] has been renamed to [common] as suggested[3], and assumes
that the "common-" prefix has been dropped from the [commands]
attribute entries. The awk script replaces the current shell script
entirely, and all common-cmds.h generation functionality is now
handled by the one awk invocation rather than by a series of commands
invoked by the shell script, which should make it faster (especially
on Windows). Finally, unlike the shell script, the awk script does
not bother sorting commands from command-list.txt since it assumes
that command sorting will happen in parallel with grouping[4].

When the awk script encounters [common], it begins collecting group
names in a grp[] array and emits the appropriate common_cmd_groups[]
"C" initializer for each. Upon encountering [commands], it switches
mode and, for each command line, checks if any attribute with which a
command is tagged exists in grp[]. If so, it emits the appropriate
common_cmds[] "C" initializer. Comment and blank lines are skipped.

By the way, Junio observed[5] that you will need to adjust a couple
Makefiles (and such) to account for the new [common] section and
[commands] header. A good start would be to filter command-list.txt
via this command:

    sed '1,/\[commands\]/d' <command-list.txt

which will strip out everything up to and including the [commands]
header.

[1]: http://article.gmane.org/gmane.comp.version-control.git/268291
[2]: http://article.gmane.org/gmane.comp.version-control.git/268294
[3]: http://article.gmane.org/gmane.comp.version-control.git/268453
[4]: http://article.gmane.org/gmane.comp.version-control.git/268442
[5]: http://article.gmane.org/gmane.comp.version-control.git/268443
[6]: Below is full patch which replaces 2/3 from this round:

--- >8 ---
=46rom: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] generate-cmdlist: parse common group commands

Parse the [common] block to create the array of group descriptions:

static char *common_cmd_groups[] =3D {
    N_("starting a working area"),
    N_("working on the current change"),
    N_("working with others"),
    N_("examining the history and state"),
    N_("growing, marking and tweaking your history"),
};

then map each element of common_cmds[] to a group via its index:

static struct cmdname_help common_cmds[] =3D {
    {"add", N_("Add file contents to the index"), 1},
    {"branch", N_("List, create, or delete branches"), 4},
    {"checkout", N_("Checkout a branch or paths to the ..."), 4},
    {"clone", N_("Clone a repository into a new directory"), 0},
    {"commit", N_("Record changes to the repository"), 4},
    ...
};

so that 'git help' can print those commands grouped by theme.

Only commands tagged with an attribute from [common] are emitted to
common_cmds[].

[commit message by S=E9bastien Guimmara <sebastien.guimmara@gmail.com>]

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Makefile             |  4 ++--
 generate-cmdlist.awk | 39 +++++++++++++++++++++++++++++++++++++++
 generate-cmdlist.sh  | 23 -----------------------
 3 files changed, 41 insertions(+), 25 deletions(-)
 create mode 100644 generate-cmdlist.awk
 delete mode 100755 generate-cmdlist.sh

diff --git a/Makefile b/Makefile
index 5f3987f..de28ae1 100644
--- a/Makefile
+++ b/Makefile
@@ -1687,10 +1687,10 @@ $(BUILT_INS): git$X
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
=20
-common-cmds.h: ./generate-cmdlist.sh command-list.txt
+common-cmds.h: generate-cmdlist.awk command-list.txt
=20
 common-cmds.h: $(wildcard Documentation/git-*.txt)
-	$(QUIET_GEN)./generate-cmdlist.sh > $@+ && mv $@+ $@
+	$(QUIET_GEN)awk -f generate-cmdlist.awk command-list.txt > $@+ && mv =
$@+ $@
=20
 SCRIPT_DEFINES =3D $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ)=
:\
diff --git a/generate-cmdlist.awk b/generate-cmdlist.awk
new file mode 100644
index 0000000..19b36e5
--- /dev/null
+++ b/generate-cmdlist.awk
@@ -0,0 +1,39 @@
+BEGIN {
+	print "/* Automatically generated */\n"
+	print "struct cmdname_help {"
+	print "\tchar name[16];"
+	print "\tchar help[80];"
+	print "\tunsigned char group;"
+	print "};\n"
+	print "static char *common_cmd_groups[] =3D {"
+}
+/^#/ || /^[ 	]*$/ { next }
+state =3D=3D 2 {
+	for (i =3D 2; i <=3D NF; i++)
+		if (grp[$i]) {
+			f =3D "Documentation/"$1".txt"
+			while (getline s <f > 0)
+				if (match(s, $1" - ")) {
+					t =3D substr(s, length($1" - ") + 1)
+					break
+				}
+			close(f)
+			printf "\t{\"%s\", N_(\"%s\"), %s},\n",
+				substr($1, length("git-") + 1), t, grp[$i] - 1
+			break
+		}
+}
+/\[commands\]/ {
+	print "};\n\nstatic struct cmdname_help common_cmds[] =3D {"
+	state =3D 2
+}
+state =3D=3D 1 {
+	grp[$1] =3D ++n
+	sub($1"[ 	][ 	]*", "")
+	printf "\tN_(\"%s\"),\n", $0
+	next
+}
+/\[common\]/ {
+	state =3D 1
+}
+END { print "};" }
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
deleted file mode 100755
index 9a4c9b9..0000000
--- a/generate-cmdlist.sh
+++ /dev/null
@@ -1,23 +0,0 @@
-#!/bin/sh
-
-echo "/* Automatically generated by $0 */
-struct cmdname_help {
-    char name[16];
-    char help[80];
-};
-
-static struct cmdname_help common_cmds[] =3D {"
-
-sed -n -e 's/^git-\([^ 	]*\)[ 	].* common.*/\1/p' command-list.txt |
-sort |
-while read cmd
-do
-     sed -n '
-     /^NAME/,/git-'"$cmd"'/H
-     ${
-	    x
-	    s/.*git-'"$cmd"' - \(.*\)/  {"'"$cmd"'", N_("\1")},/
-	    p
-     }' "Documentation/git-$cmd.txt"
-done
-echo "};"
--=20
2.4.0.319.g7a04823
--- >8 ---
