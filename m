From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] show-branch: fix segfault when showbranch.default exists
Date: Tue, 09 Jun 2009 09:28:28 -0700
Message-ID: <7viqj5nzgz.fsf@alter.siamese.dyndns.org>
References: <7vfxe9udln.fsf@alter.siamese.dyndns.org>
	<4A2E0C88.70805@gmail.com> <20090609080612.GG9993@laphroaig.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Pierre Habouzit <madcoder@madism.org>
X-From: git-owner@vger.kernel.org Tue Jun 09 18:28:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME4Be-0006jR-TI
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 18:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755947AbZFIQ22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 12:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755577AbZFIQ21
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 12:28:27 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:34717 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829AbZFIQ21 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 12:28:27 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090609162829.JET17670.fed1rmmtao101.cox.net@fed1rmimpo03.cox.net>;
          Tue, 9 Jun 2009 12:28:29 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 1sUU1c00k4aMwMQ04sUURM; Tue, 09 Jun 2009 12:28:29 -0400
X-VR-Score: -130.00
X-Authority-Analysis: v=1.0 c=1 a=IsGRFJ6KzkAA:10 a=_XXy0EWxoj8A:10
 a=ZtsLtc1TAAAA:8 a=IcTmkirJ76_eHVicv_UA:9 a=c_6I5l7cjw7Iw1t55sMA:7
 a=eCm58g6t7GlYnTbts2ClbDQ-r_kA:4 a=OH9CTqYB3BAA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121188>

Pierre Habouzit <madcoder@madism.org> writes:

> On Tue, Jun 09, 2009 at 12:17:28AM -0700, Stephen Boyd wrote:
>> Junio C Hamano wrote:
>> > I am not sure if this is a bug in parse_options(), or a bug in the caller,
>> > and tonight I do not have enough concentration to figure out which.  In
>> > any case, this patch works the issue around.
>> 
>> I am low on concentration tonight as well, but this looks right to me.
>> Parse options is expecting the regular old argv and argc. I overlooked
>> this code path during the conversion (though I remember figuring out
>> what this path was doing). Faking the argv and argc a little more
>> accurately, like you do, should work fine.
>
> yes, that's it.

Wait a minute, please.

Why is parse_options() allowed to clobber argv[0] in parse_options_end()
in the first place?

I think the memmove() is there to allow the caller to find the remaining
arguments after the library parsed out the options in argv[], but wouldn't
the caller be expecting to inspect argv[] starting from position 1?

In other words, anything moved to the position of original argv[0] would
be lost, and the problem I stumbled upon was exactly that (it triggered
because the location of argv[0] was invalid and parse_options_end() wrote
into it).
