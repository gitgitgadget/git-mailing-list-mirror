From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: refactor input parameters parse/validation
Date: Tue, 7 Oct 2008 16:39:24 +0200
Message-ID: <200810071639.25324.jnareb@gmail.com>
References: <1223054356-17643-1-git-send-email-giuseppe.bilotta@gmail.com> <200810071257.38423.jnareb@gmail.com> <cb7bb73a0810070542v4c8a9820x4d91ea20597ddf01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 16:42:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnDk0-0002ig-M7
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 16:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbYJGOji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 10:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752455AbYJGOji
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 10:39:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:33052 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbYJGOjh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 10:39:37 -0400
Received: by ug-out-1314.google.com with SMTP id k3so252784ugf.37
        for <git@vger.kernel.org>; Tue, 07 Oct 2008 07:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=uwRfdIdmjOf88h+g5gRqhZWRFQGNQlhQtHrg6n0CFm8=;
        b=deXV6H5qOv1B1e7GKPc4BwMwmItKFI2RynHiEZNW9CQdzLjs1YtbGXPy6ZkbCnJ/nf
         DxRNNYG1RRFoapZJzB+N1PiKv1JpKEr4c1kqhwpJB7WCP35i2928BKl55kaj9BofNKfd
         r5vLeyeyEe0IDYvJRe45Jp9Uly1xOJI1GweFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=CGsvZc99aTIkfBMewdyi8v2jCOjl3ClVdQHY4w1ZyXKSCi6jyziAbiNpDi3lMEk2aF
         jKxCk2KHrIxPv89f+yV13kWVoEoFj6NOfMLxzXeqWVJOj85FTVAZGJPTmz+C/M8KyusR
         NbAadmQn3glvAw2Ezl7yqEn3oiRYBFLfd9cv8=
Received: by 10.210.11.13 with SMTP id 13mr4273800ebk.13.1223390375698;
        Tue, 07 Oct 2008 07:39:35 -0700 (PDT)
Received: from ?192.168.1.11? (abww108.neoplus.adsl.tpnet.pl [83.8.246.108])
        by mx.google.com with ESMTPS id 7sm14458317eyg.0.2008.10.07.07.39.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Oct 2008 07:39:34 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0810070542v4c8a9820x4d91ea20597ddf01@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97711>

Giuseppe Bilotta wrote:
> On Tue, Oct 7, 2008 at 12:57 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Fri, 3 Oct 2008, Giuseppe Bilotta wrote:

>>> +     # find which part of PATH_INFO is project
>>> +     my $project = $path_info;
>>
>> Hmmm... now $project is local (lexically) here.
> 
> Yes, itt's only used temporarily here, to see if  a proper $project
> can be defined. It gets redefined outside. It just made sense to name
> it like this 8-)

Well, if $project is local in evaluate_path_info(), so could be
$path_info...
 
>>> +     $project =~ s,/+$,,;
>>> +     while ($project && !check_head_link("$projectroot/$project")) {
>>> +             $project =~ s,/*[^/]*$,,;
>>> +     }
>>> +     # validate project
>>> +     $project = validate_project($project);
>>
>> I'm not sure if it is worth worrying over, but I think you repeat
>> check_head_link() check here.
>>
>> [After examining code further].  But I think you do double validation;
>> once you do it here, and once you do it copying to global variables
>> such as $action or $project, and double checking check_head_link()
>> won't be easy to avoid; fortunately it is cheap filesystem-level check
>> (might be slow only when stat is extremely slow, and is not cached).
> 
> I know. This is actually the reason why I had interleaved path_info
> definition and global validation in my previous version of the patch.
> The big issue here is that path_info evaluation _needs_ (partial)
> validation.
> 
> A possible alternative could be to only put validated parameters into
> %input_params. This would completely separate the validation for cgi
> and path_info (modulo shared subs).
> 
> Of course, the check_head_link would still be repeated inside
> evaluate_path_info, but the other params could skip a double
> validation.

Wouldn't it be simpler and as good solution to just leave validation
off evaluate_path_info() (well, of course except check_head_link() test),
and allow it to be validated when assigning global 'params' variables?
check_head_link() would be repeated for path_info links, but that
should not affect performance much.

-- 
Jakub Narebski
Poland
