From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] delete_ref(): fix uninitialized value, found by valgrind
Date: Tue, 03 Feb 2009 22:00:14 -0800
Message-ID: <7v7i467ndd.fsf@gitster.siamese.dyndns.org>
References: <cover.1233684745u.git.johannes.schindelin@gmx.de>
 <alpine.DEB.1.00.0902031912290.9822@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 04 07:02:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUapW-0005dr-2h
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 07:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbZBDGAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 01:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbZBDGAV
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 01:00:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbZBDGAU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 01:00:20 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1988C2A670;
	Wed,  4 Feb 2009 01:00:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4AFA42A669; Wed, 
 4 Feb 2009 01:00:16 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0902031912290.9822@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Tue, 3 Feb 2009 19:12:40 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 19F08B80-F281-11DD-8CF7-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108298>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The variable 'err' was not necessarily initialized before it was used.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  refs.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index b13e01b..ded7ec4 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -929,7 +929,7 @@ static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
>  int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
>  {
>  	struct ref_lock *lock;
> -	int err, i = 0, ret = 0, flag = 0;
> +	int err = 0, i = 0, ret = 0, flag = 0;
>  	struct stat loginfo;
>  	int log = !lstat(git_path("logs/%s", refname), &loginfo);

Sorry, I do not see it.

There are two uses of "err" in this function, both of which looks like:

	if (err && errno != ENOENT)

but both of these places have

	err = unlink(...)

immediately before it.
