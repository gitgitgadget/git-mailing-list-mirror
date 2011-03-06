From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/12] vcs-svn: allow input errors to be detected promptly
Date: Sun, 6 Mar 2011 17:10:54 -0600
Message-ID: <20110306231054.GI24327@elie>
References: <20101210102007.GA26298@burratino>
 <20110306225419.GA24327@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 00:11:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwN6O-0000UK-25
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 00:11:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892Ab1CFXLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 18:11:00 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:56718 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab1CFXK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 18:10:59 -0500
Received: by yia27 with SMTP id 27so1420018yia.19
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 15:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=3tTi4OgfpcFPF7I31PKSRk1Dx4NWzJ1dD6vJvGPhIlE=;
        b=qEL2qx3uWMRAssSxmghWCSGk4BJKXVBiQE0SuJqbxuvod4oR0zZxOg3bAZeY+fcqic
         A54ZBwjB2l6rkpkBn2t2DwMEfeP/0ZImPeL8KqrZuuj4zYYEr3Sb5Sb33yVkRI+xRCeG
         HQr1onz/lV0269c2K9cu03ED1YPdXp8f4GNuM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=c6S3QDfNEvQyHSfpn1cu5W1ZH63aHW5Do9YOB8EXzHJ1feb9vNzvy56rpodRiqQ5zy
         /DbuKRQqe3OwnlQvOkPPXvAthTIXMSiwUaPYA3tDaCpCLeCUG9Majv8R+sWH5OPD06B+
         6MEGpDTZV7hoAf0qnKvssmVmD8RAXwxGgOM3A=
Received: by 10.150.93.2 with SMTP id q2mr3683063ybb.137.1299453058853;
        Sun, 06 Mar 2011 15:10:58 -0800 (PST)
Received: from elie (adsl-69-209-66-207.dsl.chcgil.sbcglobal.net [69.209.66.207])
        by mx.google.com with ESMTPS id l2sm1301405ybn.15.2011.03.06.15.10.57
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 15:10:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110306225419.GA24327@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168554>

Date: Sun, 10 Oct 2010 21:51:21 -0500

The line_buffer library silently flags input errors until
buffer_deinit time; unfortunately, by that point usually errno is
invalid.  Expose the error flag so callers can check for and
report errors early for easy debugging.

	some_error_prone_operation(...);
	if (buffer_ferror(buf))
		return error("input error: %s", strerror(errno));

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/line_buffer.c |    5 +++++
 vcs-svn/line_buffer.h |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index aedf105..eb8a6a7 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -59,6 +59,11 @@ long buffer_tmpfile_prepare_to_read(struct line_buffer *buf)
 	return pos;
 }
 
+int buffer_ferror(struct line_buffer *buf)
+{
+	return ferror(buf->infile);
+}
+
 int buffer_read_char(struct line_buffer *buf)
 {
 	return fgetc(buf->infile);
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index 96ce966..3c9629e 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -21,6 +21,7 @@ int buffer_tmpfile_init(struct line_buffer *buf);
 FILE *buffer_tmpfile_rewind(struct line_buffer *buf);	/* prepare to write. */
 long buffer_tmpfile_prepare_to_read(struct line_buffer *buf);
 
+int buffer_ferror(struct line_buffer *buf);
 char *buffer_read_line(struct line_buffer *buf);
 char *buffer_read_string(struct line_buffer *buf, uint32_t len);
 int buffer_read_char(struct line_buffer *buf);
-- 
1.7.4.1
