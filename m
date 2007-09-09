From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] git-tag -s must fail if gpg cannot sign the tag.
Date: Sun, 09 Sep 2007 03:37:55 +0200
Message-ID: <46E34E73.3080308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Sep 09 03:39:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IUBlm-0000vK-Vj
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 03:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755317AbXIIBiH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 21:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752358AbXIIBiG
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 21:38:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:36810 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755291AbXIIBiF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 21:38:05 -0400
Received: by ug-out-1314.google.com with SMTP id z38so374896ugc
        for <git@vger.kernel.org>; Sat, 08 Sep 2007 18:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=emD04yjHS/w97MwTRTjQndoDoGhvJaDVsAhXVpAz8C4=;
        b=Z67CPFfE0CI1U7dipUY4a1lx+lK0GAzLXZew2h3JjPYSHvdb0P8TQa1GlV+LbwrXX60pX8zE35SRJsTac6RKvDazKlQdOUAmvz9K1lhdxmT1oYnhS7ecHecjon7U159EF5sY3dgM7KxSFfVzqHCqMdkgqfFthKSSrK7E4JLrNyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=F6mUdVsuP73dbE/kOO7O1EAU6JpdX121yl7axBH9dbEtnyP7HWRHPNIg63JJiqordHrq+5BH6IBbXJ7r7DpWIrn6E1CNaGbkpegJuVausxbAq1fcdKiujMY2yAi93ZfXlULMZgy4db7zIZmlj8LgfgsbckNXtG+KuWe/teCT6sA=
Received: by 10.67.117.18 with SMTP id u18mr3043230ugm.1189301883355;
        Sat, 08 Sep 2007 18:38:03 -0700 (PDT)
Received: from ?192.168.0.192? ( [212.145.102.186])
        by mx.google.com with ESMTPS id 39sm2673220ugb.2007.09.08.18.38.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Sep 2007 18:38:01 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58141>

If the user has misconfigured `user.signingkey` in their .git/config
or just doesn't have any secret keys on their keyring and they ask
for a signed tag with `git tag -s` we better make sure the resulting
tag was actually signed by gpg.

Prior versions of builtin git-tag allowed this failure to slip
by without error as they were not checking the return value of
the finish_command() so they did not notice when gpg exited with
an error exit status.  They also did not fail if gpg produced an
empty output or if read_in_full received an error from the read
system call while trying to read the pipe back from gpg.

Finally, we did not actually honor any return value from the do_sign
function as it returns ssize_t but was being stored into an unsigned
long.  This caused the compiler to optimize out the die condition,
allowing git-tag to continue along and create the tag object.

However, when gpg gets a wrong username, it exits before any read was done
and then the writing process receives SIGNPIPE and program is terminated.
By ignoring this signal, anyway, the function write_or_die gets EPIPE from
write_in_full and exits returning 0 to the system without a message.
Here we better call to write_in_full directly so the next read can fail
printing a message and return safely to the caller.

With these issues fixed `git-tag -s` will now fail to create the
tag and will report a non-zero exit status to its caller, thereby
allowing automated helper scripts to detect (and recover from)
failure if gpg is not working properly.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---

   This patch was initially sent by Shawn in a previous email:
   http://marc.info/?l=git&m=118905254711808&w=2
   I made many tests trying to know the reason for the problem
   and these changes are the result.  I'm not sure how to send this
   right, because the patch was almost entirely from Shawn and I
   only changed a few things.  Please, see if the new test now pass
   for everybody.  Comments about the change are also welcomed.

   I always CC to my mentor, Johannes Sch., because that was
   usual when the GSoC project was active, so I continue
   doing it that way to make him able to track my contributions.
   Tell me if that's no longer necessary or it'is anoying.

 builtin-tag.c  |   14 ++++++++++----
 t/t7004-tag.sh |    7 +++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 348919c..c9be69a 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -200,6 +200,10 @@ static ssize_t do_sign(char *buffer, size_t size, size_t max)
 			bracket[1] = '\0';
 	}

+	/* When the username signingkey is bad, program could be terminated
+	 * because gpg exits without reading and then write gets SIGNPIPE. */
+	signal(SIGPIPE, SIG_IGN);
+
 	memset(&gpg, 0, sizeof(gpg));
 	gpg.argv = args;
 	gpg.in = -1;
@@ -212,12 +216,13 @@ static ssize_t do_sign(char *buffer, size_t size, size_t max)
 	if (start_command(&gpg))
 		return error("could not run gpg.");

-	write_or_die(gpg.in, buffer, size);
+	write_in_full(gpg.in, buffer, size);
 	close(gpg.in);
 	gpg.close_in = 0;
 	len = read_in_full(gpg.out, buffer + size, max - size);

-	finish_command(&gpg);
+	if (finish_command(&gpg) || !len || len < 0)
+		return error("gpg failed to sign the tag");

 	if (len == max - size)
 		return error("could not read the entire signature from gpg.");
@@ -310,9 +315,10 @@ static void create_tag(const unsigned char *object, const char *tag,
 	size += header_len;

 	if (sign) {
-		size = do_sign(buffer, size, max_size);
-		if (size < 0)
+		ssize_t r = do_sign(buffer, size, max_size);
+		if (r < 0)
 			die("unable to sign the tag");
+		size = r;
 	}

 	if (write_sha1_file(buffer, size, tag_type, result) < 0)
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 606d4f2..0d07bc3 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -990,6 +990,13 @@ test_expect_success \
 	git diff expect actual
 '

+# try to sign with bad user.signingkey
+git config user.signingkey BobTheMouse
+test_expect_failure \
+	'git-tag -s fails if gpg is misconfigured' \
+	'git tag -s -m tail tag-gpg-failure'
+git config --unset user.signingkey
+
 # try to verify without gpg:

 rm -rf gpghome
-- 
1.5.0
