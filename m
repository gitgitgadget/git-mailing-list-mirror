From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do check_repository_format() early
Date: Mon, 03 Dec 2007 10:07:12 -0800
Message-ID: <7vtzmzire7.fsf@gitster.siamese.dyndns.org>
References: <20071128165837.GA5903@laptop>
	<Pine.LNX.4.64.0711281703470.27959@racer.site>
	<fcaeb9bf0711280910x40fecdd5mf6d86e4a9b656d01@mail.gmail.com>
	<Pine.LNX.4.64.0711281717460.27959@racer.site>
	<fcaeb9bf0711280924v34160eddsf8a75f8f8cee389c@mail.gmail.com>
	<Pine.LNX.4.64.0711281810410.27959@racer.site>
	<7v3aunb0q4.fsf@gitster.siamese.dyndns.org>
	<fcaeb9bf0711302250ldfb543evd6d5f70d95ae51f7@mail.gmail.com>
	<7v4pf25jiq.fsf@gitster.siamese.dyndns.org>
	<fcaeb9bf0712030604o2efc90d0m148d3280aaa475a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 19:07:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzFhl-0003kY-Ph
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 19:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbXLCSHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 13:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbXLCSHV
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 13:07:21 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:43827 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbXLCSHU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 13:07:20 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 5F2772F0;
	Mon,  3 Dec 2007 13:07:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id AF2B79C741;
	Mon,  3 Dec 2007 13:07:35 -0500 (EST)
In-Reply-To: <fcaeb9bf0712030604o2efc90d0m148d3280aaa475a5@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Mon, 3 Dec 2007 21:04:12 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66935>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On Dec 2, 2007 1:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>  * Similarly, run a few commands in modes that do not require git
>>    repository.  For example, "git apply --stat" of an existing patch
>>    should be viewable no matter where you are (that is just a "better
>>    diffstat" mode), so ideally it should not barf only because you
>>    happen to be in a repository that is too new for you to understand.
>>    I do not know offhand how your patch would handle this situation.
>>
>> Note that making sure the latter works is tricky to do right, for a few
>> reasons.
>>
>>  (1) It is not absolutely clear what the right behaviour is.  It could
>>      be argued that we should just barf saying we found a repository we
>>      do not understand, refraining from doing any damange on it [*2*].
>>
>>  (2) If we choose not to barf on such a repository, it remains to be
>>      decided what "gently" should do --- if it should still treat
>>      t/trash/test (which has too new a version) as the found repository,
>>      or ignore it and use t/trash (which we can understand) as the found
>>      repository.  I think it should do the former.
>
> You might have forgotten the third choice: ignore t/trash/test and
> stop searching, instead pretend there is no repository at all (maybe
> with a big warning of unsupported repository).
>
> I agree t/trash should not be touched no matter what. I had enough
> "fun" with nested gitdir already. But if _gently() treats t/trash/test
> as a good repository, mysterious things may happen. Suppose gitdir v2
> supports some crazy refspec that current installed git cannot
> understand. Now you run git-remote on a v2 repository, it would end up
> barfing "invalid refspec" or something instead of "your repository
> version is not supported, upgrade git now". The latter error message
> is much clearer IMHO.
>
> If we are going "t/trash/test is good repo" route, we must make sure
> _gently() callers check repository version (and barf at proper places)
> before actually using it. Doing so makes repo version checking in
> _gently redundant, you need to check it from callers anyway as the
> callers will decide when to barf. Or return  *nongit_ok=-1 and let the
> callers check return value so they do not need to run
> check_repository_format_version() again.
>
> Comments?

I think I phrased the above (2) not brilliantly.  I meant your "third
choice" is the sane approach.  Treat t/trash/test as a found place that
we do not understand, perhaps issue a warning saying that we will
operate in there but the repository version is too new for us to
understand, but still go ahead and operate in there without doing any
repository operation (so the plain git-apply without --index will act as
if it is a GNU patch called to modify files in that directory).
