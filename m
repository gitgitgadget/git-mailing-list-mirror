X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Small optimizations to gitweb
Date: Tue, 19 Dec 2006 01:59:23 +0100
Message-ID: <200612190159.24173.jnareb@gmail.com>
References: <20061218224327.GG16029@localhost> <em77cg$obn$1@sea.gmane.org> <7vbqm0vkd6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 19 Dec 2006 00:57:07 +0000 (UTC)
Cc: git@vger.kernel.org, Robert Fitzsimons <robfitz@273k.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kmNR4LqRCWhdiPYG5cRmSIBGqbzXaSRIdJXUSyiyleZXkpJ+wmFZ538fBVPFjufDf5w666Ew6klh98OACnVkBC5NReVur2V7uMNZAHx6ucE2AYGu7wpXfOaXlXGkcLSQwnFs2ZTL8/1Wusd+yxZdDhGTTa5LQRwqum9JL0WjAqg=
User-Agent: KMail/1.9.3
In-Reply-To: <7vbqm0vkd6.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34776>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwTHp-00054s-9S for gcvg-git@gmane.org; Tue, 19 Dec
 2006 01:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932518AbWLSA4u (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 19:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbWLSA4u
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 19:56:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:2715 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932518AbWLSA4t (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec
 2006 19:56:49 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1657722uga for
 <git@vger.kernel.org>; Mon, 18 Dec 2006 16:56:48 -0800 (PST)
Received: by 10.67.20.3 with SMTP id x3mr7473483ugi.1166489807657; Mon, 18
 Dec 2006 16:56:47 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id s1sm8342810uge.2006.12.18.16.56.46; Mon, 18 Dec
 2006 16:56:46 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Actually, that is needed to implement checking if we have more than
>> the number of commits to show to add '...' at the end only if there
>> are some commits which we don't show.
> 
> The counting code in git_*_body is seriously unusual to tempt
> anybody who reviews the code to reduce that 17 to 16.
> 
> The caller says:
> 
> 	git_shortlog_body(\@revlist, 0, 15, $refs,
> 	                  $cgi->a({-href => href(action=>"shortlog")}, "..."));
> 
> If it counts up, especially if it counts from zero, the loop
> would usually say:
> 
> 	for (i = bottom; i < end; i++)
> 
> and anybody who reads that caller would expect it to show 15
> lines of output.
> 
> But the actual code does this instead:
> 
>     sub git_shortlog_body {
>             # uses global variable $project
>             my ($revlist, $from, $to, $refs, $extra) = @_;
> 
>             $from = 0 unless defined $from;
>             $to = $#{$revlist} if (!defined $to || $#{$revlist} < $to);
>             ...
>             for (my $i = $from; $i <= $to; $i++) {
>                     ... draw each item ...
>             }

Well, this should be then corrected perhaps to

            my ($revlist, $begin, $end, $refs, $extra) = @_;

            $begin = 0 unless defined $from;
            $end = scalar(@$revlist) if (!defined $end || @$revlist <= $end);
            ...
            for (my $i = $begin; $i < $end; $i++) {
                    ... draw each item ...
            }

I thought that $from..$to ($from <= i <= $to) is more natural
and easier to understand than $begin..$end ($begin <= i < $end)...
guess I guessed wrong.

>             if (defined $extra) {
>                     print "<tr>\n" .
>                           "<td colspan=\"4\">$extra</td>\n" .
>                           "</tr>\n";
>             }
>     }
> 
> By the way, I wonder how that $extra is omitted when $revlist is
> longer than $to; it should be a trivial fix but it seems to me
> that it is always spitted out with the current code.

We should check if we want to omit $extra, either in caller or
in callee, the *_body subroutine itself.

-- 
Jakub Narebski
