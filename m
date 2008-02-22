From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Better chopping in commit search results
Date: Fri, 22 Feb 2008 18:49:43 +0100
Message-ID: <200802221849.44054.jnareb@gmail.com>
References: <7vbq6kprql.fsf@gitster.siamese.dyndns.org> <20080222163035.5942.93410.stgit@localhost.localdomain> <7voda8ap6r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jean-Baptiste Quenot <jbq@caraldi.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 18:51:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSc3A-0007sR-Ub
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 18:51:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbYBVRtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 12:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbYBVRtw
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 12:49:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:43427 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932279AbYBVRtu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 12:49:50 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1357903ugc.16
        for <git@vger.kernel.org>; Fri, 22 Feb 2008 09:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=4LAA0kpa16A4LEca+C3cvwx+L+5NZ6seaiiJuhYSoVU=;
        b=F8O2431JvqM5GgMoNW3BzmUHQPmKWqNs1zNVOkh8zWuNukOFaTa6ZGsAbP7keKEiUMp3oajWJ/1pXDX+oemIn1gwChbecnfpMK3NbsKjvVbJLVR2BScHbf/0MBUrNDpMu3Fh2qVN9OxWzeF8L6VOb09p/yLDbmSqewN3wwENU9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=xGScyzdHI7IXyoV5ACNIhemoiVML5GxEcTLGajVDFmWGQHkHOtNKbay+KqOZOVCS6AuXM7onyer7gHb2qr6Bf4S0l9sEHAXgkBobRszfqK1ELqol6gvGnfxNbiMfu6DGKG4TaQ2xDt5ySKRnws6tfDHT8Eqm3bt8xez8PSgELe0=
Received: by 10.66.237.9 with SMTP id k9mr245343ugh.13.1203702589334;
        Fri, 22 Feb 2008 09:49:49 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.207.245])
        by mx.google.com with ESMTPS id e34sm2092806ugd.17.2008.02.22.09.49.46
        (version=SSLv3 cipher=OTHER);
        Fri, 22 Feb 2008 09:49:47 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7voda8ap6r.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74742>

On Fri, 22 Feb 2008, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> From: Junio C Hamano <gitster@pobox.com>
>> Subject: [PATCH] gitweb: Better chopping in commit search results
>>
>> When searching commit messages (commit search), if matched string is
>> too long, the generated HTML was munged leading to an ill-formed XHTML
>> document.
>>
>> Now gitweb chop leading, trailing and matched parts, HTML escapes
>> those parts, then composes and marks up match info.  HTML output is
>> never chopped.  Limiting matched info to 80 columns (with slop) is now
>> done by dividing remaining characters after chopping match equally to
>> leading and trailing part, not by chopping composed and HTML marked
>> output.
> 
> Could somebody test this with very long search string, as that
> was how the issue initially came up, to see (1) if it really
> fixes the "mark-up chopped in the middle" issue, (2) [...]

The bug in question was cause by the chop _after_ doing HTML
markup. Now gitweb chops, then HTML escapes, and chops no more.
There is no way this bug can happen now.

BTW if commit messages follows "wrap at 76 column" convention
it is not easy to test this condition... :-) 


But you are right that output should be improved...
 
> For example, if you are looking for "very long ... and how"
> in the first paragraph of message (if it were all on a single
> line), wouldn't you want to see:
> 
>     ...st this with <<very long ... and how>> the actual out...
> 
> rather than:
> 
>     Could som... <<very long search stri...>> the actual out...
> 
> in the result?

...but I think it is better left for another patch.

P.S. When testing this commit I have noticed that currently, probably
due to some misquoting, or interaction between escapemeta and quoting,
searching for messages which contain "'" (apostrophe), e.g. "don't"
currently doesn't work. Will investigate...
-- 
Jakub Narebski
Poland
