From: "Tor Arvid Lund" <torarvid@gmail.com>
Subject: Re: [PATCH 00/12] Allow users to access Perforce repositories requiring authentication
Date: Thu, 14 Aug 2008 19:00:12 +0200
Message-ID: <1a6be5fa0808141000w78b54bc2x1262b814f36ecdd6@mail.gmail.com>
References: <1218392795-4084-1-git-send-email-wildfire@progsoc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Simon Hausmann" <simon@lst.de>, git@vger.kernel.org
To: "Anand Kumria" <wildfire@progsoc.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 19:01:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTgCP-0002wi-5F
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 19:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbYHNRAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 13:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbYHNRAQ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 13:00:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:23025 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbYHNRAP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 13:00:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so449082fgg.17
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 10:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qaI5yBVl44nBHU42fY9sHlLNxaKvqqXTfWtVVYax99s=;
        b=Rktc/pVxy3uw3O4oF/CbeIxR7fRsZ2vXSSBeEH97Wc2kD8UXtRptWJnKrxr0sINpmE
         EBX/VxBl74vauwk0D3liFmNnp6swZVhOuWBl2pFcZiRZjmE4n03wnvy7MFuJZJB/K9ci
         XnxVBgey4zVHMFKIxSL6sB/On0eK9deUBb00s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ivaf7eYbqkLJ/EMaE7mgMoQd6Ix2gIaLDLVaQlG2GsY0Rq/uXS7vc92Tcu8TZS5vJC
         pLUcnHeOQdU72CkniP0k2IwOQn/op8Jb/NZHmhLpDs1xPAhL5nEOetOC5G/UVO1wM1NM
         pI8pvf4a5nHY0C0oLhICStV/8pdTFsikGbEHk=
Received: by 10.86.36.11 with SMTP id j11mr787542fgj.7.1218733212695;
        Thu, 14 Aug 2008 10:00:12 -0700 (PDT)
Received: by 10.86.79.9 with HTTP; Thu, 14 Aug 2008 10:00:12 -0700 (PDT)
In-Reply-To: <1218392795-4084-1-git-send-email-wildfire@progsoc.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92371>

Hi,

On Sun, Aug 10, 2008 at 8:26 PM, Anand Kumria <wildfire@progsoc.org> wrote:
> Hi,
>
> This series of patches refactors a few function calls into git-p4
> so that they all go via the same function to build up the command
> line.
>
> It also then allows users to specify any particular user / password
> required to access their Perforce repository (plus a few other parameters).
>
> I have specifically tested this agains the public Zimbra repository and
> it works for me fine. Any feedback would be welcomed.

I had an issue when using git p4 submit, and I had newly added files
in the changelist. This, I think, is caused by a call to "p4 opened"
that was not converted to use your new p4_build_cmd function. So I
don't think your patches should be merged to master before this is
fixed. However, when applying the simple diff below, this works for
me.

Otherwise, I think your patch series were very nice, since I often use
different perforce servers. Btw, my diff works correctly, I think, but
it is probably nicer to wrap read_pipe inside a p4_read_pipe - similar
to what you did with p4_read_pipe_lines. All in all: good work! :)

-Tor Arvid-

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 6c64224..8705ec9 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -134,7 +134,8 @@ def setP4ExecBit(file, mode):
 def getP4OpenedType(file):
     # Returns the perforce file type for the given file.

-    result = read_pipe("p4 opened %s" % file)
+    real_cmd = p4_build_cmd("opened %s" % file)
+    result = read_pipe(real_cmd)
     match = re.match(".*\((.+)\)\r?$", result)
     if match:
         return match.group(1)
