From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] sha1_file: make sure correct error is propagated
Date: Fri, 14 Nov 2008 22:41:21 +1300
Message-ID: <1226655681.17731.4.camel@maia.lan>
References: <1226647174-15844-1-git-send-email-sam@vilain.net>
	 <200811140844.58746.fge@one2team.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Francis Galiegue <fge@one2team.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 10:42:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0vCN-00020E-HT
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 10:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbYKNJl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 04:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbYKNJl2
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 04:41:28 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:41527 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040AbYKNJl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 04:41:27 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 5032F21C3CA; Fri, 14 Nov 2008 22:41:26 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [127.0.0.1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 14D0021C3B6;
	Fri, 14 Nov 2008 22:41:21 +1300 (NZDT)
In-Reply-To: <200811140844.58746.fge@one2team.com>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100962>

On Fri, 2008-11-14 at 08:44 +0100, Francis Galiegue wrote:
> > So, if the mkstemp() fails with EPERM, don't try to create the
> > directory - return straight away.
> Are you sure you didn't mean EACCESS?

Ah, you're right there.  Well, maybe this one should be as well:

Subject: sha1_file: accept EACCESS as equivalent to EPERM

This was testing for 'Operation not permitted' rather than any kind
of 'Permission Denied' error; prefer EACCESS.
    
Signed-off-by: Sam Vilain <sam@vilain.net>
--
  Sorry for the inevitable wrapping/whitespace fail :(

diff --git a/sha1_file.c b/sha1_file.c
index 7662330..cd422e6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2231,7 +2231,7 @@ static int create_tmpfile(char *buffer, size_t
bufsiz, const char *filename)
 	memcpy(buffer, filename, dirlen);
 	strcpy(buffer + dirlen, "tmp_obj_XXXXXX");
 	fd = mkstemp(buffer);
-	if (fd < 0 && dirlen && (errno != EPERM)) {
+	if (fd < 0 && dirlen && (errno != EACCESS)) {
 		/* Make sure the directory exists */
 		memcpy(buffer, filename, dirlen);
 		buffer[dirlen-1] = 0;
@@ -2257,7 +2257,7 @@ static int write_loose_object(const unsigned char
*sha1, char *hdr, int hdrlen,
 	filename = sha1_file_name(sha1);
 	fd = create_tmpfile(tmpfile, sizeof(tmpfile), filename);
 	if (fd < 0) {
-		if (errno == EPERM)
+		if (errno == EACCESS || errno == EPERM)
 			return error("insufficient permission for adding an object to
repository database %s\n", get_object_directory());
 		else
 			return error("unable to create temporary sha1 filename %s: %s\n",
tmpfile, strerror(errno));
