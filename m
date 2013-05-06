From: Trond Hasle Amundsen <t.h.amundsen@usit.uio.no>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: get description from repo.git/config
Date: Mon, 06 May 2013 18:26:48 +0200
Organization: Universitas Osloensis
Message-ID: <15t38u0cbw7.fsf@tux.uio.no>
References: <15tsj20cizd.fsf@tux.uio.no>
	<7vtxmgruhc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 06 18:27:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZOFe-0002an-BD
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 18:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714Ab3EFQ0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 12:26:54 -0400
Received: from mail-out4.uio.no ([129.240.10.15]:48692 "EHLO mail-out4.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836Ab3EFQ0x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 12:26:53 -0400
Received: from mail-mx4.uio.no ([129.240.10.45])
	by mail-out4.uio.no with esmtp (Exim 4.80.1)
	(envelope-from <t.h.amundsen@usit.uio.no>)
	id 1UZOFY-0002op-NH; Mon, 06 May 2013 18:26:52 +0200
Received: from tux.uio.no ([129.240.6.13])
	by mail-mx4.uio.no with esmtp  (Exim 4.80)
	(envelope-from <t.h.amundsen@usit.uio.no>)
	id 1UZOFY-0000JR-8X; Mon, 06 May 2013 18:26:52 +0200
Received: by tux.uio.no (Postfix, from userid 45150)
	id D7ED38F9; Mon,  6 May 2013 18:26:48 +0200 (CEST)
In-Reply-To: <7vtxmgruhc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 06 May 2013 08:36:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-UiO-Ratelimit-Test: rcpts/h 4 msgs/h 2 sum rcpts/h 6 sum msgs/h 3 total rcpts 5515 max rcpts/h 30 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.7, required=5.0, autolearn=disabled, RP_MATCHES_RCVD=-0.653,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: E8DB029F4816427DC6E1537AC3AF9F0C9CB74618
X-UiO-SPAM-Test: remote_host: 129.240.6.13 spam_score: -56 maxlevel 80 minaction 1 bait 0 mail/h: 2 total 1450 max/h 9 blacklist 0 greylist 1 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223468>

Junio C Hamano <gitster@pobox.com> writes:

> But when you send a patch the next time around, please have the
> above and the next three lines (i.e. "introductory text") _below_
> the three-dash line.

Allright, noted.

>> From 878a7af9088e2bcc3afc9b09b9023f1f188c844b Mon Sep 17 00:00:00 2001
>> From: Trond Hasle Amundsen <t.h.amundsen@usit.uio.no>
>> Date: Mon, 6 May 2013 15:41:25 +0200
>> Subject: [PATCH] contrib/hooks/post-receive-email: get description from repo.git/config
>
> And remove these five lines above.  We will read the authorship and
> subject from the e-mail header of your message.

So many rules.. ;) Also noted.

>> +projectdesc=$(git config gitweb.description)
>> +if [ -f "$GIT_DIR/description" ]; then
>> +        projectdesc=$(sed -ne '1p' "$GIT_DIR/description" 2>/dev/null)
>> +fi
>> +
>>  # Check if the description is unchanged from it's default, and shorten it to
>>  # a more manageable length if it is
>>  if expr "$projectdesc" : "Unnamed repository.*$" >/dev/null
>
> If description file takes precedence, then the right order to do
> this would be
>
>     projectdesc=$(sed -ne 1p "$GIT_DIR/description" 2>/dev/null)
>     if expr "$projectdesc" : "Unnamed repository" >/dev/null
>     then
>             : use it as is
>     elif projectdesc=$(git config gitweb.description)
>     then
>             : use it as is
>     else
>             projectdesc="UNNAMED PROJECT"
>     fi
>
> to avoid calling "git config" when it is not even necessary.

That doesn't work, you'll always call "git config" unless the string
matches "Unnamed repository". If you negate the expr line it still
doesn't work. To avoid calling "git config" I'd rather suggest something
like this:

  projectdesc=$(sed -ne 1p "$GIT_DIR/description" 2>/dev/null)
  if [ -z "$projectdesc" ]; then
          projectdesc=$(git config gitweb.description)
  fi

And let this block remain intact:

  if expr "$projectdesc" : "Unnamed repository.*$" >/dev/null
  then
          projectdesc="UNNAMED PROJECT"
  fi

The only change would then be the three added lines containing the if
block that calls "git config" if the "projectdesc" variable is
empty. The idea is just to get the description from config if the
description file doesn't exist.

Just curious.. why would we avoid calling "git config" unless necessary?

Regards,
-- 
Trond H. Amundsen <t.h.amundsen@usit.uio.no>
Center for Information Technology Services, University of Oslo
