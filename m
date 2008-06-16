From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: return correct HTTP status codes
Date: Mon, 16 Jun 2008 18:43:08 +0200
Message-ID: <200806161843.09372.jnareb@gmail.com>
References: <1213564515-14356-1-git-send-email-LeWiemann@gmail.com> <m37icqpb5f.fsf@localhost.localdomain> <48568D5C.5090909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Kay Sievers <kay.sievers@suse.de>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 18:44:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Hoe-0002ip-05
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 18:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304AbYFPQn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 12:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754297AbYFPQn3
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 12:43:29 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:30048 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954AbYFPQn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 12:43:28 -0400
Received: by wa-out-1112.google.com with SMTP id j37so4392708waf.23
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 09:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vaTvPLu6btfvL+QNnudsfsKMRpssfhIyfq68DpFL4Vg=;
        b=CS4/m+qiJtO6L5sKWXUJyvKjvHAnpsS3n/qnY0t+bbEr3bSIZ+vzLmag00w8sf/zkc
         pOiH99PzotN9NYs+RToO/EscxBLkX5DmzSDT7d1Bt3xmaDvXkw93PuIzbcNM0pzsDFX2
         N7L8hLM5R6gn4htRBLm0wbAAqOI4HYPLB8lck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=TMrJqvugvAVpVbwdwLroDGumIcwa9CANf4A1HqDMEq/jgrzlDn8Sck+OLxi04aiMh0
         HE3LVVfkR9zWTQYZDbM9gat8k5DQ610BbXDgHecZRG0ppSYHRicy8RQ77Z7Ra8onp8pU
         YqE2O9BKCqNLMLKqlVhiW5+Z89f2H/Nb4/lQE=
Received: by 10.114.15.16 with SMTP id 16mr6481950wao.113.1213634608020;
        Mon, 16 Jun 2008 09:43:28 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.236.117])
        by mx.google.com with ESMTPS id k26sm9602535waf.38.2008.06.16.09.43.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 09:43:26 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48568D5C.5090909@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85209>

[Fast reply, I will reply more in depth later]

Lea Wiemann wrote:
> Jakub Narebski wrote:
>> Lea Wiemann wrote:

>>>  	open my $fd, "-|", git_cmd(), "ls-tree", $base, "--", $path
>>> -		or die_error(undef, "Open git-ls-tree failed");
>>> +		or die_error(500, "Open git-ls-tree failed");
>> 
>> Should we really use "500 Internal Server Error" here?  Usually this
>> would be not an error at all, but wrong parameters to git command,
>> i.e. it is _user_ who erred, not some error on _server_ side.
> 
> You cannot tell for sure -- all you know here is that the command
> somehow failed when it shouldn't have, and so all you can give is 500;
> see below.  I don't think we should apply reasoning like "most commonly
> it's a wrong hash, so let's return 404" -- we don't know, and we
> shouldn't assume.

Well, we could, perhaps, examine stderr (or redirect it to stdout and
examine upon error) to check what was the error.  Or when/if gitweb
start to use Git.pm methods, examine catched Error (for example
"fatal: bad revision '$hash'" would mean "404 Not Found" revision).

But I think in all, or almost all cases, the source is wrong parameters
in URL.  Now, returning 5xx _server_ error would make me want to email
webmaster about error on his/her server, while 4xx _user_ error would
make me examine my input, i.e. URL I have entered, or handcrafted, or
magled.  That is IMVHO *very* important difference, and why I am
against using "500 Internal Server Error" as catch-all; I can agree
that "403 Forbidden" (which is from the times where gitweb was developed
as separate project by Kay Sievers, old, old times of v056) is better
left for disabled features[*1*], and "404 Not Found" is better
catch-all.

Kay, do you remember why "403 Forbidden" was used as default catch-all
gitweb HTTP error status code?
 
> > probably me, Petr Baudis, John Hawley, perhaps Luben Tuikov
> 
> I wouldn't want to Cc people if I don't address them personally -- e.g.
> neither Petr nor John are currently working on gitweb, so flooding their
> mailboxes might seem a little rude; if they're interested they can
> always filter for subjects.  (Unless someone requests to always be CC'ed
> of course.)

O.K. although I have though that as John is your GSoC mentor, he might
be interested gitweb caching related posts.  But this is something
better made agree with him.

BTW. I got three copies of this email: was it you fighting VGER
anti-spam filter?
-- 
Jakub Narebski
Poland
