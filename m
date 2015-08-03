From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/2] submodule: implement `module_list` as a builtin helper
Date: Mon, 03 Aug 2015 15:04:59 -0700
Message-ID: <xmqqbneo6nas.fsf@gitster.dls.corp.google.com>
References: <1438384147-3275-1-git-send-email-sbeller@google.com>
	<1438384147-3275-2-git-send-email-sbeller@google.com>
	<xmqqmvybakjl.fsf@gitster.dls.corp.google.com>
	<CAGZ79kY=39j4H=62=VZRm4VOcqzgOAU6tDpJVsqdeqnPtB8hQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 00:05:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMNr5-0000cQ-0N
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 00:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbbHCWFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 18:05:04 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34660 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbbHCWFB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 18:05:01 -0400
Received: by pdbbo16 with SMTP id bo16so21382221pdb.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 15:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=IpJvI/P2AXdKEbZQd4hYqGmKQKkJ9NDib165371BoRM=;
        b=zcIWNbsjN9dwXZNCKzjS7yyj/CroPaCwr6ZyrSCSV4JYNPrK8D760AAaWKNOp0olrp
         CmhhUlabhWEcgDuAsrNhW9vuoNw10ns7ohgjI1jiTO0wZKC+Hwu29o5ei0f7D1OCdEUa
         ZtYeRp0K3Fh9n33qlLE6A0C5xSyNIU/Ib2mnTafTAkzH3XKiJ7aYTuKll0SqicYY189J
         GKY02h/0c941P2sAt98va8X4GV+eQPPcFN4wJ8kRUetj92LMObl60Yhl3aPLdBlJLNZ5
         OLHw0Lb20IYwdPCrk5nor+0spb/lJrfTwasoenF8kSloyE2+9bfLFHXOwwiCxpJbx0Ge
         Dn3A==
X-Received: by 10.70.38.101 with SMTP id f5mr399062pdk.143.1438639500867;
        Mon, 03 Aug 2015 15:05:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:38a2:7ad5:137e:6e11])
        by smtp.gmail.com with ESMTPSA id dc8sm18600273pdb.23.2015.08.03.15.05.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Aug 2015 15:05:00 -0700 (PDT)
In-Reply-To: <CAGZ79kY=39j4H=62=VZRm4VOcqzgOAU6tDpJVsqdeqnPtB8hQQ@mail.gmail.com>
	(Stefan Beller's message of "Mon, 3 Aug 2015 14:30:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275215>

Stefan Beller <sbeller@google.com> writes:

> On Fri, Jul 31, 2015 at 6:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> +static const char * const git_submodule_helper_usage[] = {
>>> +     N_("git submodule--helper --module_list [<path>...]"),
>>
>> Yuck.  Please do not force --multi_word_opt upon us, which is simply
>> too ugly to live around here.  --module-list is perhaps OK,
>
> I agree there. The way you word it here, it sounds as if the mixture
> of dashes and underscores are a problem.
>
>> but
>> because submodule--helper would not have an default action, I'd
>> prefer to make these just "command words", i.e.
>>
>>     $ git submodule--helper module_list
>
> Why would you use an underscore in here as opposed to a dash?
>      $ git submodule--helper module-list
>
> I went with --module-list for now as I see no reason real to make it
> a command word for now ...

The biggest reason why we should not add more --command-mode is to
avoid confusion (and copy & paste misdesign by others).  If you use
the command-word interface, it is crystal clear that

 (1) the word 'module_list' must be the first token after the
     subcommand name, no need to parse "subcmd --opt --cmd", and
     mislead the users to think incorrectly that ...

 (2) ... "cmd --optA --cmd1 --optB --cmd2" might be allowed, which
     would lead you to add code to reject, saying "cmd1 and cmd2 are
     incompatible".

So I'd prefer to see it fixed before you start supporting more
commands in submodule--helper.  It will need unnecessary patch noise
to fix it later.
