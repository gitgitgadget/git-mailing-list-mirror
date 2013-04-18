From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 1/6] transport-helper: clarify *:* refspec
Date: Thu, 18 Apr 2013 09:24:41 +0100
Message-ID: <20130418082441.GR2278@serenity.lan>
References: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
 <1366258473-12841-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 10:25:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USk9P-0003Hd-9R
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 10:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965261Ab3DRIY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 04:24:57 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:43721 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831Ab3DRIYz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 04:24:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id B2027606514;
	Thu, 18 Apr 2013 09:24:54 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hzOvD28otrD5; Thu, 18 Apr 2013 09:24:54 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 07D636064E4;
	Thu, 18 Apr 2013 09:24:43 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1366258473-12841-2-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221625>

On Wed, Apr 17, 2013 at 11:14:28PM -0500, Felipe Contreras wrote:
> The *:* refspec doesn't work, and never has, clarify the code and
> documentation to reflect that. This in effect reverts commit 9e7673e
> (gitremote-helpers(1): clarify refspec behaviour).

In what way doesn't it work?  If I specify that refspec then I do get
output that appears sensible.

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/gitremote-helpers.txt |  4 ++--
>  t/t5801-remote-helpers.sh           | 15 ---------------
>  transport-helper.c                  |  2 +-
>  3 files changed, 3 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
> index f506031..0c91aba 100644
> --- a/Documentation/gitremote-helpers.txt
> +++ b/Documentation/gitremote-helpers.txt
> @@ -174,8 +174,8 @@ ref.
>  This capability can be advertised multiple times.  The first
>  applicable refspec takes precedence.  The left-hand of refspecs
>  advertised with this capability must cover all refs reported by
> -the list command.  If a helper does not need a specific 'refspec'
> -capability then it should advertise `refspec *:*`.
> +the list command.  If no 'refspec' capability is advertised,
> +there is an implied `refspec *:*`.

This is wrong.  As your later patch makes clearer, there is no implied
refspec for push - it only works for fetch.  I found the wording you've
reverted to extremely misleading.  How about something like this:

    For historical reasons, 'import' treats the absence of a 'refspec'
    line as equivalent to `refspec *:*`; remote helpers should always
    specify an explicit refspec.

?

>  'bidi-import'::
>  	This modifies the 'import' capability.
> diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
> index f387027..cd1873c 100755
> --- a/t/t5801-remote-helpers.sh
> +++ b/t/t5801-remote-helpers.sh
> @@ -120,21 +120,6 @@ test_expect_failure 'pushing without refspecs' '
>  	compare_refs local2 HEAD server HEAD
>  '
>  
> -test_expect_success 'pulling with straight refspec' '
> -	(cd local2 &&
> -	GIT_REMOTE_TESTGIT_REFSPEC="*:*" git pull) &&
> -	compare_refs local2 HEAD server HEAD
> -'
> -
> -test_expect_failure 'pushing with straight refspec' '
> -	test_when_finished "(cd local2 && git reset --hard origin)" &&
> -	(cd local2 &&
> -	echo content >>file &&
> -	git commit -a -m eleven &&
> -	GIT_REMOTE_TESTGIT_REFSPEC="*:*" git push) &&
> -	compare_refs local2 HEAD server HEAD
> -'
> -
>  test_expect_success 'pulling without marks' '
>  	(cd local2 &&
>  	GIT_REMOTE_TESTGIT_NO_MARKS=1 git pull) &&
> diff --git a/transport-helper.c b/transport-helper.c
> index dcd8d97..cea787c 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -469,7 +469,7 @@ static int fetch_with_import(struct transport *transport,
>  	 * were fetching.
>  	 *
>  	 * (If no "refspec" capability was specified, for historical
> -	 * reasons we default to *:*.)
> +	 * reasons we default to the equivalent of *:*.)
>  	 *
>  	 * Store the result in to_fetch[i].old_sha1.  Callers such
>  	 * as "git fetch" can use the value to write feedback to the
> -- 
> 1.8.2.1.679.g509521a
