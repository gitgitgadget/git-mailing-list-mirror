From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 1/2] submodule: fix confusing variable name
Date: Thu, 08 Aug 2013 18:44:22 +0100
Message-ID: <5203D8F6.2020102@ramsay1.demon.co.uk>
References: <1375550060-5406-1-git-send-email-sandals@crustytoothpaste.net> <1375550060-5406-2-git-send-email-sandals@crustytoothpaste.net> <20130803181415.GF2893@elie.Belkin> <51FE90B8.8030203@web.de> <20130804212938.GL19369@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, judge.packham@gmail.com,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr, gitster@pobox.com
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 19:11:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7qDy-0004fH-3F
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 19:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883Ab3HIRLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 13:11:34 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:34309 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751592Ab3HIRLd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 13:11:33 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 556B94011A8;
	Fri,  9 Aug 2013 18:11:31 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 75FD3400CAE;
	Fri,  9 Aug 2013 18:11:30 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Fri,  9 Aug 2013 18:11:26 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <20130804212938.GL19369@paksenarrion.iveqy.com>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231997>

Fredrik Gustafsson wrote:
> On Sun, Aug 04, 2013 at 07:34:48PM +0200, Jens Lehmann wrote:
>> But we'll have to use sm_path here (like everywhere else in the
>> submodule script), because we'll run into problems under Windows
>> otherwise (see 64394e3ae9 for details). Apart from that the patch
>> is fine.
> 
> We're still using path= in the foreach-script. Or rather, we're setting
> it. From what I can see and from the commit message 64394e3ae9 it could
> possible be a problem.

Please do not use a $path variable in any script intended to be run on
windows; those poor souls who would otherwise have to fix the bugs will
thank you! :-D

Actually, it's not so much the use of a $path variable, rather the act
of _exporting_ such a variable that causes the problem. (Which is why
using $path with eval_gettext[ln] is such a problem, of course.)

As noted in the above commit, $path is unfortunately a documented part
of the public API for the foreach subcommand. However, the foreach
subcommand is (mostly) fine; given the fact that the user script is
eval-ed in a context in which $path is not exported. The reason for
the 'mostly' is simply that the user could shoot himself in the foot
by export-ing $path in their script, so that something like:

    $ git submodule foreach 'export path; echo $path `git rev-parse HEAD`'

will indeed fail (ie git rev-parse will not execute).

> Not sure how to solve it though... Just a simple correction would break
> all script depending on that.

$path is part of the public API, so we can't just remove it. It would
require a deprecation period, etc,.  (Adding/documenting $sm_path as an
alternative *may* be worth doing. dunno.)

HTH

ATB,
Ramsay Jones
