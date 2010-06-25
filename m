From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH v3 3/3] Don't expand CRLFs when normalizing text during merge
Date: Fri, 25 Jun 2010 09:58:35 +0200
Message-ID: <FB02F1B0-9FE7-4B7B-BA30-5A510F83BCE7@gmail.com>
References: <cover.1277408598.git.eyvind.bernhardsen@gmail.com> <90f38b5f5c49f9b9f5427a026e51f867a1121982.1277408598.git.eyvind.bernhardsen@gmail.com> <4C244278.10407@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jun 25 09:58:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OS3oH-0006am-MK
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 09:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750Ab0FYH6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 03:58:42 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44365 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554Ab0FYH6l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jun 2010 03:58:41 -0400
Received: by wyi11 with SMTP id 11so2280666wyi.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 00:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:in-reply-to
         :mime-version:content-type:message-id:content-transfer-encoding:cc
         :from:subject:date:to:x-mailer;
        bh=TtQFHv7hOGsETcpOjzUVw2pNg3edWh2mE9JuuUW4tQw=;
        b=IiwnoO9xm7uAkf/jjqEHrYRIdkYHa2dayRCt9DeYRhAA45H6aXJG/8aWcIVDkwdP8J
         g9NVKtuos69ndW0AuoN19Z7Zh7wTFxnzA3bTabyo6lJbpzTzO4v1QMGSvYH8M2kP1/YM
         h7PPXfNcVpBIIX10LBhXEwPbBGSZImLIRKbys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-type:message-id
         :content-transfer-encoding:cc:from:subject:date:to:x-mailer;
        b=b67jW3mGubsNLI4h/nlubkJALE5wi1hMeELSxP0D14H4pxjxd41m03VTas9RRA25nl
         oL5Xpe3Zv7tLuh6fOiJvF4/J0Qlm4t1t+zzq1fCzCluQn8j0WBGYGntv5+NC+Z3zcxOr
         TBcS66Suw0QWjtQNRKfhj9/uar6iAzMcSieLw=
Received: by 10.227.127.85 with SMTP id f21mr233097wbs.115.1277452720027;
        Fri, 25 Jun 2010 00:58:40 -0700 (PDT)
Received: from [10.36.80.159] ([62.113.137.5])
        by mx.google.com with ESMTPS id t15sm76528819wbc.23.2010.06.25.00.58.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 25 Jun 2010 00:58:39 -0700 (PDT)
In-Reply-To: <4C244278.10407@viscovery.net>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149669>

On 25. juni 2010, at 07.45, Johannes Sixt wrote:

> Am 6/24/2010 22:44, schrieb Eyvind Bernhardsen:
>> There's no need to expand CRLFs when convert_to_working_tree() is called
>> to normalize text for a merge since the text will be converted back
>> immediately.  Improves performance of merges with conflicting line
>> endings when core.eol=crlf or core.autocrlf=true.
> 
> Pardon me, first you make a big deal about normalization for merges, only
> that you finally omit it? What am I missing?

Sorry, I didn't explain that very well.  I noticed that normalize_buffer() does more work when core.eol=crlf than it does when core.eol=lf: _to_working_tree() converts LF to CRLF, and then _to_git() reverses that conversion.  This patch makes normalization act the same way when core.eol=crlf as it does when core.eol=lf.

That implies a lack of symmetry in the way the crlf_to_git() and crlf_to_worktree() functions are called, but that asymmetry already exists when core.eol=lf since crlf_to_worktree() returns immediately when no output conversion is required.

I considered temporarily setting the "eol" and "auto_crlf" globals in normalize_buffer(), but messing with global variables felt wrong and this gives the same result (almost: it also disables conversion when a file has text=crlf, but that is a further optimization).

> BTW, most of the new functions you introduced violate the style: they
> should have the opening brace on the next line.

Ah, will fix.  Thanks.
-- 
Eyvind Bernhardsen
