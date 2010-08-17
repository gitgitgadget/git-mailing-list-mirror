From: Tor Arvid Lund <torarvid@gmail.com>
Subject: BUG?: git-apply sometimes says "corrupt patch" when adding single lines
Date: Wed, 18 Aug 2010 01:27:27 +0200
Message-ID: <AANLkTineHiG9vCpbJzJ2x9CFjZ7LQeExs7cN5YhoZhft@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 01:27:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlVZA-0007lJ-QT
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 01:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878Ab0HQX1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 19:27:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33709 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab0HQX13 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 19:27:29 -0400
Received: by iwn7 with SMTP id 7so1845524iwn.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 16:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=jTOtU4FBahjBEIRwO7Y/54V1P5RRNFWsd/eOfB17D1s=;
        b=RJfbtW/4Ja+iFjOm8jGQgCv4lGETQ+JP2lFyMgv6dv5v00JPs+La2vpJ11opC5WMk+
         4+FkRNtQsHghQH57YcFpYbwxXgP08y/FkFgafkxcvwK/m75QrjIfzyNZf1oxtcmcOFMC
         81NLVMi7gNWPnghGU9s51rQWYnxuQTl6cfb5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=DwFb5OquQ0fMGiR6csM5VMEbJuLKItc+yd9F3OacWxMvbSdJlH3uVBe9xe4Te0VYqM
         QnKjYXDnw1xIMXqBYfassWxIdUjW181X+G91TAncb3L+z3BQX52BvtzMQAHBEdgFJ1ex
         J5nDwuEYXg9VNc6DbRdvduvqgBX5dvawGsSjY=
Received: by 10.231.39.69 with SMTP id f5mr8356119ibe.53.1282087647208; Tue,
 17 Aug 2010 16:27:27 -0700 (PDT)
Received: by 10.231.177.194 with HTTP; Tue, 17 Aug 2010 16:27:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153788>

Hi.

I often use git-gui when staging commits, and I noticed that if the
file I'm working with has a:

\ No newline at end of file

... as the last line of the diff, and I try to "Stage lines for
commit", then git-gui (or really git-apply, as I understand it) says
that I have a "corrupt patch at line <so-and-so>".

I don't really know the git-gui code or the git C code well, but it
seems that I got around the error with this small patch:

diff --git a/builtin/apply.c b/builtin/apply.c
index 12ef9ea..124791f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1335,6 +1335,8 @@ static int parse_fragment(char *line, unsigned long size,
 		 * l10n of "\ No newline..." is at least that long.
 		 */
 		case '\\':
+			if (newlines == oldlines == 1)
+				newlines = oldlines = 0;
 			if (len < 12 || memcmp(line, "\\ ", 2))
 				return -1;
 			break;




Is this a bug? Or is it maybe git-gui that sends something wrong to
git-apply? I don't know... :-/

(I'm using msysGit on Windows, if that matters)

-Tor Arvid-
