From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1] send-email: provide whitelist of SMTP AUTH mechanisms
Date: Sun, 02 Aug 2015 11:28:49 -0700
Message-ID: <xmqqwpxd8rz2.fsf@gitster.dls.corp.google.com>
References: <1438385617-29159-1-git-send-email-viktorin@rehivetech.com>
	<CAPig+cT842GAFFM-wfjSU1ZiOevDCOPNDWxux6-vqtdr=3F4qw@mail.gmail.com>
	<20150801201950.5d8c1951@jvn>
	<CAPig+cQwgYYYYsszaRdJDwFLLB0PmiDQ_WTa+Nzzoq0U1zuMiA@mail.gmail.com>
	<20150802184353.2a5da936@jvn>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Jan Viktorin <viktorin@rehivetech.com>
X-From: git-owner@vger.kernel.org Sun Aug 02 20:28:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLy0G-0005bG-Hk
	for gcvg-git-2@plane.gmane.org; Sun, 02 Aug 2015 20:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbbHBS2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2015 14:28:52 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33956 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbbHBS2v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2015 14:28:51 -0400
Received: by pdbbo16 with SMTP id bo16so6970640pdb.1
        for <git@vger.kernel.org>; Sun, 02 Aug 2015 11:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=mzFbEa3yf+v7NF6NP4vlWhJUrsITq3aR6ADAuhFP2ZE=;
        b=J3uwUXZelsfLa9Mbv5FBc4OTOMnCtWmFXGVI7k4ut2H0Q9KpRypAUTbkYuK6RaJs2w
         Xksd2EhonfkgAvVlKtSipJEz79RJiGMl5fx76O22JbfQT/SVS9AgGqRimhGUgdIpGhII
         /52q8uWsDwguqpwPzoIiWYb7G7izq8jyt4gVofQFrZVEhvsJXO7I3uRKLnDxuGp18ltV
         LO02202ayhD7gCDuFouHuwrxH7Cwo1uXZ4xRw7/T56hgM9s9MXlFI4LGhRP+ShkS6+M0
         hDPE44rqJZnyn0mW9JLaP7Gct1Qly6AqOBFUtG3FcGKUWQz+HMM/a4w8StDgK0Z9cAEZ
         1x6w==
X-Received: by 10.70.37.207 with SMTP id a15mr28740098pdk.4.1438540131507;
        Sun, 02 Aug 2015 11:28:51 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:9922:d65f:3652:1a73])
        by smtp.gmail.com with ESMTPSA id l2sm5589080pdd.65.2015.08.02.11.28.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 02 Aug 2015 11:28:50 -0700 (PDT)
In-Reply-To: <20150802184353.2a5da936@jvn> (Jan Viktorin's message of "Sun, 2
	Aug 2015 18:43:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275149>

Jan Viktorin <viktorin@rehivetech.com> writes:

> Authen::SASL gives:
>
> No SASL mechanism found
>  at /usr/share/perl5/vendor_perl/Authen/SASL.pm line 77.
>  at /usr/share/perl5/core_perl/Net/SMTP.pm line 207.
>
> The SASL library does not check validity of mechanisms'
> names (or I did not find it). It just tries to load one
> that matches both the ours and the server side ones.
> ...
> I would like to include the regex check based on RFC 4422
> as I've already mentioned. at least, it filters out the
> unwanted characters like '/', '.', etc.

Hmm, is there a way to ask Authen::SASL what SASL mechanism the
installed system supports?  If so, the enhancement you are adding
could be

	my @to_use;
	if ($smtp_auth_whitelist is supplied) {
		my @installed = Authen::SASL::list_mechanisms();
                for (@installed) {
                	if ($_ is whitelisted) {
				push @to_use, $_;
			}
		}
	}

and @to_use can later be supplied when we open the connection as the
list of mechanisms we allow the library to pick.

Just my $.02
