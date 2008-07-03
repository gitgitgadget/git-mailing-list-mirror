From: Junio C Hamano <gitster@pobox.com>
Subject: Re: PATCH: allow ':/<oneline prefix>' notation to specify a specific
 file
Date: Thu, 03 Jul 2008 02:20:17 -0700
Message-ID: <7v7ic32ujy.fsf@gitster.siamese.dyndns.org>
References: <279b37b20807030152g13492d5dxf21367ab17719993@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: "Eric Raible" <raible@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 13:55:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KENPJ-0001Xp-DT
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 13:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbYGCLy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 07:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbYGCLy1
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 07:54:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37803 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbYGCLy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 07:54:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6E1ECD2FF;
	Thu,  3 Jul 2008 05:20:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A4628D2F8; Thu,  3 Jul 2008 05:20:20 -0400 (EDT)
In-Reply-To: <279b37b20807030152g13492d5dxf21367ab17719993@mail.gmail.com>
 (Eric Raible's message of "Thu, 3 Jul 2008 01:52:45 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 45A6D63E-48E1-11DD-A1F0-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87265>

"Eric Raible" <raible@gmail.com> writes:

> This patch allows git show ":/PATCH: allow":sha1_name.c to show the
> change to the file changed by this patch.
> ...
> @@ -697,8 +698,18 @@ int get_sha1_with_mode(const char *name, unsigned
> char *sha1, unsigned *mode)
>  		int stage = 0;
>  		struct cache_entry *ce;
>  		int pos;
> -		if (namelen > 2 && name[1] == '/')
> -			return get_sha1_oneline(name + 2, sha1);
> +		if (namelen > 2 && name[1] == '/') {
> +			name += 2;
> +			colon = strrchr(name, ':');
> +			if (!get_sha1_oneline(name, sha1) || !colon)
> +				return 0;

So when you have ":/A:B:C", you first try to look for string "A:B:C", and
then when it fails try "A:B" and look for path C?  I think this fallback
makes sense, especially because this cannot break existing use for
positive lookup (it _can_ be called a regression if you are checking to
see if you have a commit that has A:B:C and you want the lookup to fail if
there is A:B that happens to have path C, but I do not think we would care
about that usage).

A few observations:

 (1) An obvious micro-optimization. Check if "A:B:C" is a rev, and if and
     only if it fails, run strrchr() to find fallback point;

 (2) When you do not find either "A:B:C" nor "A:B", perhaps try "A" and
     find "B:C" as a path in it?  IOW, you may want to fallback more than
     once;

 (3) If you are given ":/A~20" or ":/A^2", perhaps you would want to do
     something similar?

Other than that, I like what the patch is trying to do.     
