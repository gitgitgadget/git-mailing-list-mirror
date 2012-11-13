From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] update-index/diff-index: use core.preloadindex
 to improve performance
Date: Tue, 13 Nov 2012 08:46:06 -0800
Message-ID: <7v4nktfo35.fsf@alter.siamese.dyndns.org>
References: <20121102153800.GE11170@sigill.intra.peff.net>
 <OF27D0F811.18A373FB-ONC1257AB5.0055809D-C1257AB5.0055B47D@dcon.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org, 
 msysgit@googlegroups.com,  pro-logic@optusnet.com.au
To: karsten.blees@dcon.de
X-From: msysgit+bncBCG77UMM3EJRBUPSRGCQKGQEAV5CGMY@googlegroups.com Tue Nov 13 17:46:23 2012
Return-path: <msysgit+bncBCG77UMM3EJRBUPSRGCQKGQEAV5CGMY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ye0-f186.google.com ([209.85.213.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBUPSRGCQKGQEAV5CGMY@googlegroups.com>)
	id 1TYJcz-0003qM-PI
	for gcvm-msysgit@m.gmane.org; Tue, 13 Nov 2012 17:46:22 +0100
Received: by mail-ye0-f186.google.com with SMTP id q5sf5923295yen.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Nov 2012 08:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=3Ak5Y5O13lc5q+grvannhH7g0gXTwfOZbLZJ07DavWQ=;
        b=n7X1rhxOLuyCAPiAqhbzfplHPPXUMuSi+UI++qeyDZmnNTqeZy/guO0tZ7KJ6lsbsU
         IHNiD1Y1upNrZROuI/VDt8g2avna8fkaKTm796QIxLhl+uIDhwdBg7N7XAFk5RjV04oE
         KTeNC/ysTkawi9Nm1fZ7RbZds6PbDStmVkUcN9C4+lL3Ks6zV/16JWA84uRzIrAyrZyt
         MirQ3qHkAQ0ei12pk3O5XAGpzIzhHkzImAO+mhRgm5ax6uXPC6Ht7FlkT3GjRzR3ecgr
         T/PwFsrqRNXj0PpGhvVClsROZvpv5d+OpW8PyzBlP7oi48zVzBOR+IezdNEbq348jbU 
Received: by 10.52.175.73 with SMTP id by9mr4447749vdc.1.1352825171528;
        Tue, 13 Nov 2012 08:46:11 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.52.35.20 with SMTP id d20ls9200307vdj.7.gmail; Tue, 13 Nov
 2012 08:46:09 -0800 (PST)
Received: by 10.52.33.199 with SMTP id t7mr8963326vdi.7.1352825169743;
        Tue, 13 Nov 2012 08:46:09 -0800 (PST)
Received: by 10.52.33.199 with SMTP id t7mr8963322vdi.7.1352825169540;
        Tue, 13 Nov 2012 08:46:09 -0800 (PST)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id es5si3572340vdb.2.2012.11.13.08.46.09;
        Tue, 13 Nov 2012 08:46:09 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1039EAC7C;
	Tue, 13 Nov 2012 11:46:09 -0500 (EST)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1E16AC7B;
	Tue, 13 Nov 2012 11:46:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52576AC78; Tue, 13 Nov 2012
 11:46:08 -0500 (EST)
In-Reply-To: <OF27D0F811.18A373FB-ONC1257AB5.0055809D-C1257AB5.0055B47D@dcon.de> (karsten
 blees's message of "Tue, 13 Nov 2012 16:36:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F87A93A-2DB1-11E2-BADE-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 best guess record for domain of junio@b-sasl-quonix.pobox.com designates
 208.72.237.35 as permitted sender) smtp.mail=junio@b-sasl-quonix.pobox.com;
 dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209632>

karsten.blees@dcon.de writes:

> Jeff King <peff@peff.net> wrote on 02.11.2012 16:38:00:
>
>> On Fri, Nov 02, 2012 at 11:26:16AM -0400, Jeff King wrote:
>> 
>> > Still, I don't think we need to worry about performance regressions,
>> > because people who don't have a setup suitable for it will not turn on
>> > core.preloadindex in the first place. And if they have it on, the more
>> > places we use it, probably the better.
>> 
>> BTW, your patch was badly damaged in transit (wrapped, and tabs
>> converted to spaces). I was able to fix it up, but please check your
>> mailer's settings.
>> 
>
> Yes, I feared as much, that's why I included the pull URL (the company MTA 
> only accepts outbound mail from Notes clients, sorry).
>
> Is there a policy for people with broken mailers (send patch as 
> attachment, add pull URL more prominently, don't include plaintext patch 
> at all...)?

If anything, "fix your mailer" probably is the policy you are
looking for, I think.

-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en
