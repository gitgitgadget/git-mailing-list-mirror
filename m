From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git-submodule.sh respects submodule.$name.update in .git/config
 but not .gitmodules
Date: Wed, 11 Dec 2013 23:26:17 +0100
Message-ID: <52A8E689.80701@web.de>
References: <CABYr9QtSeX=Euf73MZPq6suo+GpVA=f+tH73Ct0tP-3LYogh9w@mail.gmail.com>	<20131209223506.GF9606@sandbox-ub> <xmqqlhztvbi8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Charlie Dyson <charlie@charliedyson.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Dec 11 23:26:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqsEZ-0005Vm-V3
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 23:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566Ab3LKW0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 17:26:20 -0500
Received: from mout-xforward.web.de ([82.165.159.2]:54073 "EHLO
	mout-xforward.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab3LKW0T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 17:26:19 -0500
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Dec 2013 17:26:19 EST
Received: from [192.168.178.41] ([84.132.161.19]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0Lc8Xx-1VA4lw2l41-00jYCg for <git@vger.kernel.org>;
 Wed, 11 Dec 2013 23:26:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <xmqqlhztvbi8.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:sQy8GHSvvd24hS2kTV73Kev50N4RP3SD8pXX5/3SuWdOWv4Nluy
 8Qc8uMd5I7o3g+5IcXEdehtbIO/kRcc9+Vzt+xdYe9Dagvnlhs9joReyk2CYgUkNqrMgmCg
 Ih/G8zaxP9nVJRJ943rcH+icEoK5yK/vcxoOGEHowFwt8KhMrOTidMuI6PhM7/FY/J2FQtw
 PNnLcTC5cW4tcAx+1j8HQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239213>

Am 10.12.2013 00:40, schrieb Junio C Hamano:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
>> This notion has changed in a way that only the url (by that the name)
>> should be copied on init. The default for everything else should come
>> from .gitmodules or gits own default.
> 
> I think you need to be a bit careful here.  I do not think
> everything should blindly default to .gitmodules (otherwise there
> are obvious security implications as well as usability ones).

I believe everything except the URL should default to .gitmodules,
for the same reasons we already do that for fetch and ignore [1].
But it should not do so blindly and take precautions that this
only happens for safe values.

The only current exception is the update setting, but I'd like to
change that in two steps:

1) Teach git-submodule.sh to fall back to the update setting from
   .gitmodules if none is found in .git/config (more details below)

2) Wait some time and remove the copying on init later (to make
   life easier for people who are working on the same checkout
   with different versions of git).

>> The update configuration option was implemented before we realized that.
>> So currently it is still copied when submodule init is called. The main
>> reason is that we have not found the time to change that.
> 
> And 'update', as it allows any custom way to run it, is unlikely to
> be allowed to be used blindly from .gitmodules, no?

Definitely not. And while thinking about it it might make sense to
pass a list of allowed values for all configurations to the
get_submodule_config() function, making sure that fallbacks are only
used when they are safe.

[1] http://thread.gmane.org/gmane.comp.version-control.git/161193/focus=161357
