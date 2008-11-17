From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv3 3/4] gitweb: separate heads and remotes lists
Date: Mon, 17 Nov 2008 14:11:02 +0100
Message-ID: <cb7bb73a0811170511s4df6efbbl220fa89469388aca@mail.gmail.com>
References: <1226842089-1159-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226842089-1159-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226842089-1159-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226842089-1159-4-git-send-email-giuseppe.bilotta@gmail.com>
	 <7viqqn377m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>,
	"Petr Baudis" <pasky@suse.cz>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 14:12:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L23tw-0001Sj-8E
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 14:12:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbYKQNLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 08:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbYKQNLH
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 08:11:07 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:44504 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbYKQNLE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 08:11:04 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1150536nfc.21
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 05:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=0qgJba3n43WEXM67GaZZwlXdGRlq8A3JkGaq1e/vglA=;
        b=dnLt4OOF4f238Pi9Q8n3pTJdDgijZUUnOBQj1lAZc8J7s4JSNm0Flu30Hl1ybszjyn
         OuRMTN17KWjoEjf0E5kv8naKXhTH58zoZREBXt1w+Fth8YQP9vra0ako0AfsfWLcg15p
         4/ZE5o8BD2kdgX9QWI3AASpMpyaUC1jEaXe7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=QLe054avsm2kV5gHk/+HyvzSonK1Lf+IGllCCzwULysKf/K4ndZsYg1H9SLooYbcFz
         4Pjg1MgvDhdZr1zZ1VMi9N+cbXSajVrexNM5BgRWcaRmkxVOwZ6vjAXVL3C85JVhF/ec
         IoeajTdGcXsH3qTdvUl9pvEMSpavK+UXKhuNI=
Received: by 10.210.45.14 with SMTP id s14mr3931586ebs.64.1226927462652;
        Mon, 17 Nov 2008 05:11:02 -0800 (PST)
Received: by 10.210.132.16 with HTTP; Mon, 17 Nov 2008 05:11:02 -0800 (PST)
In-Reply-To: <7viqqn377m.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101225>

On Sun, Nov 16, 2008 at 6:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>> -     my @headlist = git_get_heads_list(16);
>> +     my @headlist = git_get_heads_list(16, 'heads');
>> +     my @remotelist = $remote_heads ? git_get_heads_list(16, 'remotes') : ();
>
> Wasteful to run one for-each-ref for each list.
>
> You earlier introduced $ref_item{'class'} so that you can differenciate
> what you got from git_get_heads_list(); make use of it, perhaps like:
>
>        my @heads_list = git_get_heads_list(16, \%head_class);
>        my @headlist = grep { $_->{'class'} eq 'head' } @heads_list;
>        my @remotelist = grep { $_->{'class'} eq 'remote' } @heads_list;
>
> By the way, your [2/4] used "heads" and "remotes" as class, while your
> [1/4] stored 'head' and 'remote' in $ref_item{'class'}.  Notice the above
> suggestion corrects this discrepancy as well.

Although I agree with the head_class idea, I would like to point out
that doing a single git call to retrieve all refs and then selecting
the ones we want and doing multiple git calls are not equivalent.

First of all, with multiple calls we can limit the calls to retrieve
at most 16 refs of each kind, whereas this cannot be done with a
single call for all the refs. I'm not sure however, performance-wise,
if it's faster to filter the first 16 refs of each after retrieving
all of them, or doing multiple calls, especially with lots of refs.

Moreover, gitweb is already doing multiple for-each-ref calls to get
tags and heads. I guess that at this point we could go the extra mile
and include tags in the refs management. Of course, the problem of how
to handle the rate limiting remains.


-- 
Giuseppe "Oblomov" Bilotta
