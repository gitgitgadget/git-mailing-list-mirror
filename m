From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 3/3] submodule: Reimplement `module_clone` shell function in C
Date: Tue, 08 Sep 2015 15:46:23 -0700
Message-ID: <xmqqr3m87cn4.fsf@gitster.mtv.corp.google.com>
References: <1441230146-26921-1-git-send-email-sbeller@google.com>
	<1441230146-26921-4-git-send-email-sbeller@google.com>
	<xmqq8u8ni2bv.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYAsNZ1huLrYOvyPtYHKoN4paBGXbY3OMX3SQNMwqCiKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 00:46:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZReu-0005rE-H3
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 00:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036AbbIHWq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 18:46:28 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:32860 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbbIHWqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 18:46:25 -0400
Received: by pacex6 with SMTP id ex6so136245544pac.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2015 15:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=AOutSx85ZfTgXpSJdolSqvNnLtqksdj+RalBhLNke1o=;
        b=oGAy2OOhYm8AeyLAvOc/fotgkGL+jHn72AI1HfgDGhVI2Io/8llOZ0EO6qdZ1zzkWc
         A8MgCSQddY44fSS35i1NHA3rew0+tTHMCvt0kD3vd3vy4FQ5N+cwrIvYgdlROC9HEj46
         hHFqG5tK+b57+7j1u1TaQuSnA5YBsd74GnLeQKYWff453G9Sh/RPxY/jrTQDrchhH13s
         odb6r4E4dkPXTF0PMhc3GSOQ+XDsUFD4IRBWmx/28wgHz9ARuRonXUtBoEKelNkWzatU
         e9+MMFmz7EqxHHRKywrYgFIEqbnicOz+uUQAWR1CO4GmnPLV3t6uNFguf/9SSQ1Nu07j
         atXg==
X-Received: by 10.68.93.133 with SMTP id cu5mr63824815pbb.71.1441752384864;
        Tue, 08 Sep 2015 15:46:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:40ca:ccb5:4636:e6d])
        by smtp.gmail.com with ESMTPSA id i9sm4614309pbq.84.2015.09.08.15.46.23
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 08 Sep 2015 15:46:24 -0700 (PDT)
In-Reply-To: <CAGZ79kYAsNZ1huLrYOvyPtYHKoN4paBGXbY3OMX3SQNMwqCiKA@mail.gmail.com>
	(Stefan Beller's message of "Tue, 8 Sep 2015 11:31:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277529>

Stefan Beller <sbeller@google.com> writes:

> On Thu, Sep 3, 2015 at 3:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> +
>>> +     cp.no_stdin = 1;
>>> +     cp.no_stdout = 1;
>>> +     cp.no_stderr = 1;
>>
>> Output from "git clone" is not shown, regardless of --quiet option?
>
> Removed that.
>
>>> +     argc = parse_options(argc, argv, prefix, module_clone_options,
>>> +                          git_submodule_helper_usage, 0);
>>> +
>>> +     strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
>>
>> The original says
>>
>>         base_name=$(dirname "$name")
>> ...
> Slashes are already in use for submodule names as the name defaults
> to the path if no explicit name is given.

Ahh, OK, that base_name thing is so that "mkdir -p" can create a
surrounding directory without creating the final level, which is
left for 'git clone" to prepare.  I misread the code.  Thanks.
