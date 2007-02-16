From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Allow config files to be included
Date: Fri, 16 Feb 2007 15:42:30 +0100
Message-ID: <81b0412b0702160642h69b632f0w6c1decc4ec04c24a@mail.gmail.com>
References: <200702140909.28369.andyparkins@gmail.com>
	 <Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vfy98snus.fsf@assigned-by-dhcp.cox.net>
	 <200702151019.25409.andyparkins@gmail.com>
	 <20070215113557.GB2282@steel.home> <20070216143952.GA2478@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 16 15:43:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI4Iv-0004pg-Dd
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 15:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbXBPOmd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 09:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422638AbXBPOmd
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 09:42:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:1125 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422634AbXBPOmc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 09:42:32 -0500
Received: by ug-out-1314.google.com with SMTP id 44so164010uga
        for <git@vger.kernel.org>; Fri, 16 Feb 2007 06:42:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eNkN6lKoKbWq16inrJ44N+n4pzjKq77jTuA8i5/O/i4WMfhYMljoV8kdb4wC6rhBSH9hrzailhQ1K9mtJQR+oshKkXlhAe9Rob2J7I5BF3yIElNvfxjtb44HA/9X6bWil1tald4NR28fQHnIR+Mh4HrAWqr6LCK1jF/V+KujgQM=
Received: by 10.78.136.9 with SMTP id j9mr612564hud.1171636950455;
        Fri, 16 Feb 2007 06:42:30 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Fri, 16 Feb 2007 06:42:30 -0800 (PST)
In-Reply-To: <20070216143952.GA2478@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39916>

The syntax is:

    [include "filename"]

which is somewhat branch/remote-alike. There are a few differences, though:
filenames happen to be long, so a backslash is supported to split the
names into multiple lines. No bare LF allowed, so this is illegal:
    [include "path/
    name"]
On the other hand, this is allowed:
    [include "path/\
    name"]

Backslash is just to quote characters (as in shell).
Only one quoted string allowed, so this is bad too:

    [include "path/" "name"]

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

This is a resend, I have no idea what happened to original,
but it never appeared on vger. And this will probably horribly
garbled by gmail. Will see.

Alex Riesen, Thu, Feb 15, 2007 12:35:57 +0100:
> I suggest to ignore /etc/gitconfig completely if ~/.gitconfig exists,
> but allow inclusion of /etc/gitconfig from ~/.gitconfig (there are
> very singular and preciuos exceptions).

 config.c |  103 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 100 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index d821071..b42a7ea 100644
--- a/config.c
+++ b/config.c
@@ -12,6 +12,57 @@
 static FILE *config_file;
 static const char *config_file_name;
 static int config_linenr;
+
+struct fileinfo
+{
+       char *name;
+       int linenr;
+       FILE *file;
+       struct fileinfo *prev;
+};
+static struct fileinfo *config_stack = NULL;
+
+static void include_file(const char *filename)
+{
+       struct fileinfo *prev;
+       FILE *file;
+       file = fopen(filename, "r");
+       if (!file) {
+               error("ignored \"%s\": %s", filename, strerror(errno));
+               return;
+       }
+       prev = malloc(sizeof(*prev));
+       prev->name = (char *)config_file_name;
+       prev->linenr = config_linenr;
+       prev->file = config_file;
+       prev->prev = config_stack;
+       config_stack = prev;
+
+       config_file = file;
+       config_file_name = xstrdup(filename);
+       config_linenr = 0;
+}
+
+static FILE *pop_file(void)
+{
+       struct fileinfo *prev;
+
+       if (!config_stack)
+               /* The last file on stack does not belong to us.
+                * Free the names and close all included files. */
+               return NULL;
+
+       free((void*)config_file_name);
+       fclose(config_file);
+       config_file = config_stack->file;
+       config_file_name = config_stack->name;
+       config_linenr = 0;
+       prev = config_stack->prev;
+       free(config_stack);
+       config_stack = prev;
+       return config_file;
+}
+
 static int get_next_char(void)
 {
        int c;
@@ -31,13 +82,51 @@ static int get_next_char(void)
                if (c == '\n')
                        config_linenr++;
                if (c == EOF) {
-                       config_file = NULL;
+                       config_file = pop_file();
                        c = '\n';
                }
        }
        return c;
 }

+static int parse_include(void)
+{
+       char name[PATH_MAX];
+       int quote = 0, len = 0;
+
+       for (;;) {
+               int c = get_next_char();
+               if (len >= sizeof(name))
+                       return -1;
+               if (c == '"') {
+                       quote++;
+                       continue;
+               }
+               if (c == '\n')
+                       /* do not allow bare \n anywhere in path */
+                       return -1;
+               if (quote == 1) {
+                       if (c == '\\') {
+                               c = get_next_char();
+                               if (c == '\n')
+                                       continue;
+                       }
+                       name[len++] = c;
+               }
+               if (quote == 2 && c == ']') {
+                       do
+                               c = get_next_char();
+                       while (c != '\n');
+                       break;
+               }
+               if ((quote < 1 || quote >= 2) && !isspace(c) )
+                       return -1;
+       }
+       name[len] = '\0';
+       include_file(name);
+       return 0;
+}
+
 static char *parse_value(void)
 {
        static char value[1024];
@@ -181,8 +270,13 @@ static int get_base_var(char *name)
                int c = get_next_char();
                if (c == EOF)
                        return -1;
+               if (!isalpha(c) && !strncmp(name, "include", baselen) &&
+                   config_file) {
+                       ungetc(c, config_file);
+                       return parse_include();
+               }
                if (c == ']')
-                       return baselen;
+                       return baselen ? baselen: -1;
                if (isspace(c))
                        return get_extended_base_var(name, baselen, c);
                if (!iskeychar(c) && c != '.')
@@ -216,8 +310,11 @@ static int git_parse_file(config_fn_t fn)
                }
                if (c == '[') {
                        baselen = get_base_var(var);
-                       if (baselen <= 0)
+                       if (baselen < 0)
                                break;
+                       if (!baselen)
+                               /* [include "..."]*/
+                               continue;
                        var[baselen++] = '.';
                        var[baselen] = 0;
                        continue;
--
1.5.0.138.g36f81
