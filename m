From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Silence stderr in parse_commit*() subroutines
Date: Mon, 13 Feb 2012 20:04:41 +0100
Message-ID: <201202132004.41991.jnareb@gmail.com>
References: <5fa08a8b-f0a2-4796-bf0d-06a8f13bf703@b23g2000yqn.googlegroups.com> <201202131915.01753.jnareb@gmail.com> <CA+EqV8xin_ubOoGouhHz2qnzoHrpMMQsjUTXnrtmsxRTLPZtZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: rajesh boyapati <boyapatisrajesh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 20:04:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx1Ck-0002q1-Cb
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 20:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757575Ab2BMTEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 14:04:45 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:40527 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811Ab2BMTEp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 14:04:45 -0500
Received: by eekc14 with SMTP id c14so1961565eek.19
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 11:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=zdiliUJFzM4Nf7KAzNYuDgrw/jyLRS8Hhc6moNwA+hI=;
        b=PTO+zV9Knkh0hRXwjxnmadmtb3L3qlwsFbwUslnG1E/mbfz2n7Uj6AUFAnG/SXeXbx
         PxDRLngoKyY/pOZAaCKAg5rGsCKeqcMprJJ7rkvKVw8tXPfrtwRZEnwFKVA0BgbgLOuB
         YOdtdniba6m7/EktReOpA4YA+KjXgDIsVdx4I=
Received: by 10.14.101.134 with SMTP id b6mr5645182eeg.81.1329159883886;
        Mon, 13 Feb 2012 11:04:43 -0800 (PST)
Received: from [192.168.1.13] (aeho143.neoplus.adsl.tpnet.pl. [79.186.196.143])
        by mx.google.com with ESMTPS id o49sm63975821eei.0.2012.02.13.11.04.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Feb 2012 11:04:43 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <CA+EqV8xin_ubOoGouhHz2qnzoHrpMMQsjUTXnrtmsxRTLPZtZQ@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190649>

On Mon, 13 Feb 2012, rajesh boyapati wrote:
> 2012/2/13 Jakub Narebski <jnareb@gmail.com>
>> On Mon, 13 Feb 2012, rajesh boyapati wrote:

>>> I am getting this error with this patch
>>>>>>>>>>>>>>>>>>>>>
>>> [2012-02-13 11:20:19,268] ERROR
>>> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: usage: git rev-list
>>> [OPTION] <commit-id>... [ -- paths... ]
>>> [2012-02-13 11:20:19,268] ERROR
>>> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI:   limiting output:
>>> [2012-02-13 11:20:19,268] ERROR
>>> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI:     --max-count=nr
>> [...]
>>> [2012-02-13 11:20:27,913] ERROR
>>> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: bad flag '--2'
>>> used after filename
>>> [2012-02-13 11:20:32,579] ERROR
>>> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: bad flag '--2'
>>> used after filename
>>> <<<<<<<<<<<<<<<<<<<
>>
>> Strange, I cannot reproduce this with non-Gerrit gitweb.  It looks
>> like it somehow lost in between "... -- 2>/dev/null" at the end of
>> git-rev-list command, and fails at "--2" which is bad flag.
>>
> This is the patch I applied
>>>>>>>>>>>>>
> sub parse_commit {
>     my ($commit_id) = @_;
>     my %co;
> 
>         return unless defined $commit_id;
> 
>     local $/ = "\0";
> 
>     *open my $fd, "-|", quote_command(
>              git_cmd(), "rev-list",*
>         "--parents",
>         "--header",
>         "--max-count=1",
>         $commit_id,
>        * "--") . '2>/dev/null',*
                   ^^^^^^^^^^^^^

It should be ' 2>/dev/null', with space before redirection, and not
'2>/dev/null'.  This space is here necessary.

> With this Patch, Gerrit's gitweb is not showing anything.
> I mean, I can access gitweb from gerrit, but if I click on Tabs(like log,
> commit, etc...which worked with previous patches), I cannot see any thing.
> 
> Even with previous patches also there is no improvement in Gerrit's gitweb,
> only some of the errors are gone in error_log.
> The improvement I am talking about is "If I click other tabs(log, shortlog,
> commit, tree,etc) after clicking "summary", Gerrit's gitweb is not showing
> anything".

Many views in gitweb do default to HEAD.  If HEAD does not point to a valid
commit, they would fail, in better or worse way.

Except for the first one those patches are more of band-aid and workaround
than fixing underlying issue that gitweb assumes that HEAD is valid in 
non-empty repository.  But fixing this will require more work.

-- 
Jakub Narebski
Poland
