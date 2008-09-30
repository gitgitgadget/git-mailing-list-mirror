From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/6] gitweb: action in path with use_pathinfo
Date: Tue, 30 Sep 2008 10:05:59 +0200
Message-ID: <cb7bb73a0809300105s24706d79hb40e147739ec6f05@mail.gmail.com>
References: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200809290303.21290.jnareb@gmail.com>
	 <cb7bb73a0809290722w5ed92171v98d6b83a7dae8f8b@mail.gmail.com>
	 <200809300221.25094.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@ucw.cz>,
	"Lea Wiemann" <lewiemann@gmail.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 10:17:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkaGJ-0001i7-C6
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 10:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbYI3IGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 04:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752787AbYI3IGE
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 04:06:04 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:44517 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbYI3IGB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 04:06:01 -0400
Received: by gxk9 with SMTP id 9so11501984gxk.13
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 01:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=rSRnbo2YQUeHP9paevafM3IBqFoKqAszgmnhVP1idIY=;
        b=kGxNk4T4q3wRfdPovVOG3jpU2im+lWJvBu60mzTfdUvBXZQOdj67sBUWkdL/YGCLjP
         ynob3Wu4u4bmu39MrWZLapdjEc2dX/XI9hx4TmImT+AWZcahpYo2Hzr+o3MsB1Xrfilm
         t/8CiTcw5mO+va3Vv0C1odQO5ydLl3TDgj404=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ody2s9vHpAkve6u0Xegy+Y4WsifiGPfgeELJslEew+DtbVdAmFOc/VXwdh54GM35Hk
         39dlafgr9cI+xBjQuPhHvhTRMfkMPaot5K0G061Dz6ZHCTruZjc7CqwqClikDDWb/z98
         zzO3NgFRwveh/2xMDCNTiyvr6/PL559iZGovQ=
Received: by 10.151.145.11 with SMTP id x11mr9492373ybn.218.1222761959766;
        Tue, 30 Sep 2008 01:05:59 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Tue, 30 Sep 2008 01:05:59 -0700 (PDT)
In-Reply-To: <200809300221.25094.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97078>

On Tue, Sep 30, 2008 at 2:21 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> Perhaps not in so large and detailed form... I guess explanation of
> using ':/' as separator should be put there as well, if you plan to
> squash those patches.

I will add the explanation for the :/ separator in the patch for URL
generation (forgot it in v3)

>>>> @@ -624,8 +636,13 @@ sub href (%) {
>>>>       if ($params{-replay}) {
>>>>               while (my ($name, $symbol) = each %mapping) {
>>>>                       if (!exists $params{$name}) {
>>>> -                             # to allow for multivalued params we use arrayref form
>>>> -                             $params{$name} = [ $cgi->param($symbol) ];
>>>> +                             if ($cgi->param($symbol)) {
>>>> +                                     # to allow for multivalued params we use arrayref form
>>>> +                                     $params{$name} = [ $cgi->param($symbol) ];
>>>> +                             } else {
>>>> +                                     no strict 'refs';
>>>> +                                     $params{$name} = $$name if $$name;
>>>> +                             }
>>>>                       }
>>>>               }
>>>>       }
>>>
>>> What this change is about? And why this change is _here_, in this
>>> commit? It is I think unrelated, and wrong change.
>>
>> This is about being able to recycle CGI parameters that came through
>> as part of path_info instead of the CGI parameter list. It might not
>> be the best way to recover it, though. I *did* have a few thoughts
>> about an alternative way that consisted of build a parameter list
>> merging CGI and path-info parameter, but since this approach seemed to
>> work, I went with it.
>
> Fact, I have totally forgot about this.

Me too actually (the first version of this patch is almost a year old,
and since I forgot to write down why I did a few things ... taught me
that I should start putting more comments, though 8-D)

>>> href(..., -replay=>1) is all about reusing current URL, perhaps with
>>> a few parameters changed, like for example pagination links differ only
>>> in page number param change.  For example if we had only hb= and f=
>>> parameters, -replay=>1 links should use only those, and not add h=
>>> parameter because somewhere we felt that we need $hash to be calculated.
>>
>> Assume for example that you are to an url such as
>>
>> http://git.oblomov.eu/git/tree/refs/remotes/origin/master:gitweb
>>
>> Without this patch, the 'history' link on the second header line links
>> to ARRAY(0xblah)ARRAY(0xblah). With this patch, it shows the proper
>> link. So either replay is being abused somewhere in the link
>> generation code, or this CGI+path_info parameter retrieval is
>> necessary, one way or the other.
>
> Ah.  Now I understand.
>
> When creating code for href(..., -replay=>1), which by the way I thought
> would be more useful than actually is, I have forgot that parameters to
> gitweb could be passed in other way that through CGI parameters
> (CGI query)[1].
>
> Using
>
>        $params{$name} = [ $cgi->param($symbol) ];
>
> is a cute hack, but it doesn't work for arguments passed via path_info
> (was: project, hash_base and file_name; while now it is project, action,
> hash_base (in full) and file_name).

Exactly.

> The solution I thought about and abandoned in favor of this cute hack
> was to have additional hash (in addition to %mapping), which would map
> action names to references to variables holding the value for parameter.
>
> This has the same problem as your proposed solution of putting some
> parameters which didn't come from URL but were filled from other info.
> $hash parameter is most likely to be culprit here.
>
> On the other hand it is more generic and doesn't rely on knowledge that
> there is no multi-valued parameter which can be expressed in path_info
> (currently only 'opt' parameter can be multi-valued, and requires
> arrayref, but also 'opt' parameter is and cannot be put in path_info).
>
> I am talking there about the following solution:
>
>        my %action_vars = (
>                project => \$project,
>                action => \$action,
>                # ...
>                extra_options => \@extra_options,
>        );
>        # ...
>        while (my ($name, $symbol) = each %mapping) {
>                if (!exists $params{$name}) {
>                          $params{$name} = ${$action_vars{$name}};
>                }
>        }
>
>
> This avoids cure hack of (from your code)
>
>                } else {
>                           no strict 'refs';
>                           $params{$name} = $$name if $$name;
>                }
>
> I think that gitweb should use single source, not CGI query parameters
> or variable saving [sanitized] value.

The alternative I've been thinking about would be to have an
%input_parameters hash that holds all input parameters regardless of
hash; thus CGI query parameters and data extracted from PATH_INFO,
presently, but also command line options in the future, or whatever
else.

This is somewhat different from your %action_vars alternative, in the
sense that it isolates _input_ data, whereas if I understand correctly
the approach you suggest would isolate _output_ data (in the sense of
data to be used during link creation and whatnot).

Presently, the gitweb code defines some $variables from the input
parameters, and then overwrites them for output. Keeping the input
stuff clearly separate from the output stuff would mean that any
routine can retrieve the input data regardless of the subsequent
mangling and without any need to make ad-hoc backups or other tricks.

So my proposal is that I implement this %input_params stuff as the
first patch for the pathinfo series, and use %input_params all around
where cgi parameters are used currently (of course, %input_params is
initialized with the CGI parameters at first). The next patch would be
the extraction of parameters from PATH_INFO. And thirdly the PATH_INFO
URL generation (with or without the /-before-filename thing, at your
preference)

-- 
Giuseppe "Oblomov" Bilotta
