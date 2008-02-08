From: Junio C Hamano <gitster@pobox.com>
Subject: [Janitors] value could be NULL in config parser
Date: Thu, 07 Feb 2008 22:43:23 -0800
Message-ID: <7v63x0lzhw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 07:44:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNMy2-0001RL-HP
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 07:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768AbYBHGng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 01:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754651AbYBHGng
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 01:43:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64149 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214AbYBHGnf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 01:43:35 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F34F632A;
	Fri,  8 Feb 2008 01:43:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 41A366328;
	Fri,  8 Feb 2008 01:43:31 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73044>

If somebody wants to dip his or her toe in git hacking, and is
tempted to send in a "clean up" patch (e.g. whitespace, coding
style) that does not really _fix_ anything, please don't.

I have a task of similar complexity (meaning, reasonably easy)
that is much more useful and appreciated than clean-up patches
for you.

The callback functions that are passed to git_config() need to
be audited so that they do not barf when given NULL.  Currently,
many of them are not safe.

A callback function of git_config() is called when the command
reads value from .git/config and friends.  The function takes
two parameters, var and value.  var is never NULL and it is the
name of the configuration variable found in the file being
read.  value could be either string or NULL.

A NULL value is boolean "true".  For example, on MS-DOS, you may
have something like this:

	[core]
 		autocrlf

and your callback will be called with var = "core.autocrlf" and
value = NULL in such a case.

If you want to fix them (you do not have to do all of them, and
if you would like to help, please make one patch per function
fixed), the procedure is:

 (1) Find calling sites for git_config().  For example, we find
     one in archive-tar.c::write_tar_archive().

        int write_tar_archive(struct archiver_args *args)
        {
                int plen = args->base ? strlen(args->base) : 0;

                git_config(git_tar_config);

                archive_time = args->time;
                verbose = args->verbose;
	...

 (2) Look at the function that is passed to git_config().

        static int git_tar_config(const char *var, const char *value)
        {
                if (!strcmp(var, "tar.umask")) {
                        if (!strcmp(value, "user")) {
                                tar_umask = umask(0);
                                umask(tar_umask);
                        } else {
                                tar_umask = git_config_int(var, value);
                        }
                        return 0;
                }
                return git_default_config(var, value);
        }

 (3) Let's fix it.  If the user's configuration has:

	[tar]
        	umask

     it is an illegal configuration, but the code above does not
     check for NULL, and the second strcmp() would fail.  If we
     guard that strcmp() with a check against NULL, we would be
     Ok.  git_config_int() will correctly barf telling the user
     that "tar.umask" configuration is wrong.

 (4) Then send in a patch.  Again, one patch per fixed function,
     please.  The message may look like this:

-- >8 --
[PATCH] archive-tar.c: guard config parser from value=NULL

Signed-off-by: A U Thor <author@example.com>

 archive-tar.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index e1bced5..30aa2e2 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -222,7 +222,7 @@ static void write_global_extended_header(const unsigned char *sha1)
 static int git_tar_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "tar.umask")) {
-		if (!strcmp(value, "user")) {
+		if (value && !strcmp(value, "user")) {
 			tar_umask = umask(0);
 			umask(tar_umask);
 		} else {
