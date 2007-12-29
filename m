From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Speedup prefixcmp() common case
Date: Sat, 29 Dec 2007 21:43:14 +0100
Message-ID: <e5bfff550712291243x6f8d7b2k15055ff55379142e@mail.gmail.com>
References: <e5bfff550712291001q5f246ceah6700b98308fb96f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 29 21:44:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8iXY-0004z9-GJ
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 21:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbXL2UnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 15:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbXL2UnQ
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 15:43:16 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:8951 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbXL2UnP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 15:43:15 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3970683rvb.1
        for <git@vger.kernel.org>; Sat, 29 Dec 2007 12:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=DrNskrBpITS6yTStH/VpZAQZI+mJ09HVn9ZbpMz6rFQ=;
        b=V+sK4LF71hv22KX5O7QJjRaeSnDsR+E3Crf2XlfajpLi+i9UUKXf1qovIXDIPNXjr5sCVPr+4b1Mc4xLJhy8S/o9J/Xf9W1vJEhKzmaA1qQ6OSIxLs/adVoxLdcfwVcW6NPQM8Xh9akhFaG0yliSq5SM4Uqqiaf7/+9UURgV5wk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K/EDi8YfnwQs8xzXZ1pRSmuufI/XG0jub1Dv67U+T7bK9az4xSaKIzI4omAsANAz7TSaHN+kL2oOvHYuZHbrbTL2Q8w3LBlOu66rcSRD1V7v9jzpR6nPiqOfZNyIxQIL6PNj2QgW/C4LO4AOOOdGJHIb8QefGwYBzWb0egAus5w=
Received: by 10.140.249.20 with SMTP id w20mr5547505rvh.66.1198960994864;
        Sat, 29 Dec 2007 12:43:14 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sat, 29 Dec 2007 12:43:14 -0800 (PST)
In-Reply-To: <e5bfff550712291001q5f246ceah6700b98308fb96f1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69331>

In case the prefix string is a single char avoid a
costly call to strlen() + strncmp()

With this patch git log with --pretty=format option
is 10% faster

With suggestions by Junio C Hamano

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---


 git-compat-util.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 79eb10e..e26b684 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -398,6 +398,10 @@ static inline int sane_case

 static inline int prefixcmp(const char *str, const char *prefix)
 {
+       /* shortcut common case of a single char prefix */
+       if (prefix && !prefix[1] && str)
+               return *str - *prefix;
+
       return strncmp(str, prefix, strlen(prefix));
 }

--
1.5.4.rc2-dirty
