From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/2] Introduce remove_dir_recursively()
Date: Sat, 29 Sep 2007 00:14:46 +0200
Message-ID: <85k5qabfop.fsf@lola.goethe.zz>
References: <Pine.LNX.4.64.0709280602580.28395@racer.site>
	<Pine.LNX.4.64.0709280606350.28395@racer.site>
	<7v8x6rqhwy.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709281323300.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 29 00:15:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbO6w-0008Ve-4z
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 00:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478AbXI1WO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 18:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753457AbXI1WOz
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 18:14:55 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:32789 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753355AbXI1WOz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Sep 2007 18:14:55 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 9298B241C54;
	Sat, 29 Sep 2007 00:14:53 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 7B3B423D342;
	Sat, 29 Sep 2007 00:14:53 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-178.pools.arcor-ip.net [84.61.10.178])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 291151C36C4;
	Sat, 29 Sep 2007 00:14:49 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id D46421C06F89; Sat, 29 Sep 2007 00:14:47 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0709281323300.28395@racer.site> (Johannes Schindelin's message of "Fri\, 28 Sep 2007 13\:35\:21 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4421/Fri Sep 28 23:09:13 2007 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59426>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 28 Sep 2007, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > +int remove_dir_recursively(char *path, int len, int only_empty)
>> > +{
>> > ...
>> > +		namlen = strlen(e->d_name);
>> > +		if (len + namlen > PATH_MAX ||
>> > +				!memcpy(path + len, e->d_name, namlen) ||
>> > +				(path[len + namlen] = '\0') ||
>> > +				lstat(path, &st))
>> > +			; /* fall thru */
>> > +		else if (S_ISDIR(st.st_mode)) {
>> > +			if (!remove_dir_recursively(path, len + namlen,
>> > +						only_empty))
>> > +				continue; /* happy */
>> > +		} else if (!only_empty &&
>> > +				len + namlen + 1 < PATH_MAX &&
>> > +				!unlink(path))
>> > +			continue; /* happy, too */
>> > +
>> > +		/* path too long, stat fails, or non-directory still exists */
>> > +		ret = -1;
>> > +		break;
>> 
>> Is it only me who finds the first if () condition way too
>> convoluted and needs to read three times to convince oneself
>> that it is doing a sane thing?
>> 
>> Please, especially...
>> 
>>  * For $DEITY's sake, memcpy() returns pointer to dst which you
>>    know is not NULL. so !memcpy() is always false here, which
>>    might be _convenient_ for you and the compiler but not for
>>    a human reader of the code who needs to blink twice wondering
>>    if you meant !memcmp().
>> 
>>  * Same for (path[] = '\0'), wondering if it is misspelled
>>    (path[] == '\0').
>
> Okay, will fix (with an evil goto).

Uh, C has a comma operator.  And inverting the first condition makes
for a nicer flow, no goto.

		namlen = strlen(e->d_name);
		if (len + namlen <= PATH_MAX
			&& (memcpy(path + len, e->d_name, namlen),
			    path[len + namlen] = '\0',
			    lstat(path, &st) == 0)
		if (S_ISDIR(st.st_mode)) {
			if (!remove_dir_recursively(path, len + namlen,
						only_empty))
			continue; /* happy */
		} else if (!only_empty &&
				len + namlen + 1 < PATH_MAX &&
				!unlink(path))
			continue; /* happy, too */

		/* path too long, stat fails, or non-directory still exists */
		ret = -1;
		break;


-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
