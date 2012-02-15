From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Silence stderr in parse_commit*() subroutines
Date: Wed, 15 Feb 2012 11:04:54 +0100
Message-ID: <201202151104.55348.jnareb@gmail.com>
References: <5fa08a8b-f0a2-4796-bf0d-06a8f13bf703@b23g2000yqn.googlegroups.com> <201202132004.41991.jnareb@gmail.com> <CA+EqV8w5jCHa2NY+NLaht901Qk=kQvALG3EA6BkePiGow3YFeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: rajesh boyapati <boyapatisrajesh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 15 11:05:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxbjb-0008D4-DI
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 11:05:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592Ab2BOKFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 05:05:03 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49272 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903Ab2BOKFB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 05:05:01 -0500
Received: by eaah12 with SMTP id h12so277398eaa.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 02:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=BV//fTramHajBvU6R0/L/l97GHXWTPoJ2SY1y6jiGqw=;
        b=W8DsKN31PAfv+9w5xovuGeie/PVnSgv4IFjNlIKwJ941XI5b5jP8ONmaZG5u9vwHlb
         RTPbwptkahQWM8CCJFEU0Pt4j1Yx+wLzT/wa1w1fA+ukyJxM5QUmViEIViw3MbS5e80f
         rzJw5O/iWUO7ieLhDwYxaQCvEJspRe3BrZK+0=
Received: by 10.213.10.4 with SMTP id n4mr143278ebn.34.1329300299425;
        Wed, 15 Feb 2012 02:04:59 -0800 (PST)
Received: from [192.168.1.13] (abwo207.neoplus.adsl.tpnet.pl. [83.8.238.207])
        by mx.google.com with ESMTPS id n17sm9496854eei.3.2012.02.15.02.04.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 15 Feb 2012 02:04:58 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <CA+EqV8w5jCHa2NY+NLaht901Qk=kQvALG3EA6BkePiGow3YFeQ@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190821>

On Mon, 13 Feb 2012, rajesh boyapati wrote:
> 2012/2/13 Jakub Narebski <jnareb@gmail.com>
>> On Mon, 13 Feb 2012, rajesh boyapati wrote:


>>> This is the patch I applied
>>>>>>>>>>>>>>>
>>> sub parse_commit {
>>>     my ($commit_id) = @_;
>>>     my %co;
>>>
>>>         return unless defined $commit_id;
>>>
>>>     local $/ = "\0";
>>>
>>>     *open my $fd, "-|", quote_command(
>>>              git_cmd(), "rev-list",*
>>>         "--parents",
>>>         "--header",
>>>         "--max-count=1",
>>>         $commit_id,
>>>        * "--") . '2>/dev/null',*
>>                   ^^^^^^^^^^^^^
>>
>> It should be ' 2>/dev/null', with space before redirection, and not
>> '2>/dev/null'.  This space is here necessary.
> 
> 
> Sorry for the typo error. I changed that and I am now seeing this error in
> Gerrit's error_log
> <<<<<<<<<<<<<
> [2012-02-13 13:45:35,201] ERROR
> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: Not a valid
> object name HEAD
> >>>>>>>>>>>>>

WTF, redirecting stderr (file descriptor number 2) to /dev/null should have
silenced git-rev-list in case of errors.

Compare

  $ git rev-list foo --
  fatal: bad revision 'foo'

with

  $ git rev-list foo -- 2>/dev/null

which gives no output.

I wonder what shell does gitweb use if run from com.google.gerrit.httpd
as servlet...

[...]
>> Many views in gitweb do default to HEAD.  If HEAD does not point to a valid
>> commit, they would fail, in better or worse way.
>>
>> Except for the first one those patches are more of band-aid and workaround
>> than fixing underlying issue that gitweb assumes that HEAD is valid in
>> non-empty repository.  But fixing this will require more work.
>>
> Yes, I agree with you.
>
> If the HEAD's in a git project are pointed to master branch, those are fine
> with Gerrits gitweb. Everything is working fine. (See the images in attached
> file "Master.zip")
> 
> For the HEAD's in the git projects that are pointed to a branch other than
> master (I mean if master branch is empty), I have the problem when I click
> on tabs (log, shortlog, commit, commitdiff, tree) after clicking "summary"
> tab.  (See the images in attched file "Unborn-branch.zip").

That is because those views defaults to HEAD, which doesn't point to
a valid commit because 'master' branch it does point to doesn't have any
commits on it.  They should probably be disabled (grayed-out, and made
ordinary text and not hyperlink) if HEAD is invalid.

But this would require more work than those patches.
>
> If I click other tabs before clicking "summary" tab, they are working fine.

That is because if you select some branch, then all those views use
currently selected branch (passed via URL, e.g. 'h' or 'hb' parameter
in case of query-params URL).

-- 
Jakub Narebski
Poland
