From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] add -u: get rid of "treewideupdate" configuration
Date: Sat, 9 Apr 2011 11:38:24 +0700
Message-ID: <20110409043824.GA22543@do>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-3-git-send-email-gitster@pobox.com>
 <20110408175149.GA3917@sigill.intra.peff.net>
 <7vaag04k8m.fsf@alter.siamese.dyndns.org>
 <20110408202404.GA16540@sigill.intra.peff.net>
 <7vmxk01izn.fsf@alter.siamese.dyndns.org>
 <20110408223206.GA7343@sigill.intra.peff.net>
 <7vei5c1iat.fsf@alter.siamese.dyndns.org>
 <7vaag01gdl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 06:41:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8Pz0-0000SY-UC
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 06:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497Ab1DIElJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 00:41:09 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34709 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab1DIElH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 00:41:07 -0400
Received: by iyb14 with SMTP id 14so3991817iyb.19
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 21:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=TmMz3kF11hLWmTQcp+zS63z5yELQwp0G4mk014/lt0s=;
        b=OmmtFVP+B1bZm8Ckh0PqbbDrKwYjNcNHu3Mh4TD52fe5MgoPjJnNKvVrbyK/DtavCy
         tNBr/BVfkBygS9Kax1VH4cMhdUPJtrVUl2VP0LTF/3MYiXKuz5j/x55r66VrSk+LtlGu
         fkhHd6URc88QOJttsjN2yb1bWJ/+zacifhypE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=L8IlnzwtveXPyom5EZt1O3yBbw5UEIE2yKdMyNYby0T/5YychoXODq/iI0LbPIkmAw
         K0UVUjXXTPLA3mBOC9gTpTQWnfX6JHbywNRniDi2cYAX0gZSOcTEJnZdk+ctiDNNBmDD
         hbtSWbDNmqRadsvLHg5Zsp+lYsnrLb7ED6hSw=
Received: by 10.42.240.202 with SMTP id lb10mr1789194icb.297.1302324066561;
        Fri, 08 Apr 2011 21:41:06 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.238.90])
        by mx.google.com with ESMTPS id i26sm1246222iby.41.2011.04.08.21.41.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Apr 2011 21:41:05 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 09 Apr 2011 11:38:24 +0700
Content-Disposition: inline
In-Reply-To: <7vaag01gdl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171180>

On Fri, Apr 08, 2011 at 04:18:46PM -0700, Junio C Hamano wrote:
> It appears that we might want to further tweak the code that tries to
> disambiguate between revs and paths (we error out when argv[i] does not
> name a rev and lstat(argv[i]) fails)

Something like below? The additional goodness is, instead of writing

git grep foo -- '*.a'

I can now write a shorter version

git grep foo :./*.a

Perhaps we can use the first pathspec with magic as a mark of
pathspec arguments, equivalent to "--"

--8<--
diff --git a/setup.c b/setup.c
index 03cd84f..a00a23f 100644
--- a/setup.c
+++ b/setup.c
@@ -73,6 +73,8 @@ int check_filename(const char *prefix, const char *arg)
 	const char *name;
 	struct stat st;
 
+	if (*arg == ':')	/* pathspec magic */
+		return 1;
 	name = prefix ? prefix_filename(prefix, strlen(prefix), arg) : arg;
 	if (!lstat(name, &st))
 		return 1; /* file exists */
--8<--
-- 
Duy
