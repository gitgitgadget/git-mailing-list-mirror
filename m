From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Allow cloning an empty repository
Date: Fri, 23 Jan 2009 02:46:42 +0100
Message-ID: <bd6139dc0901221746h258f548etf857ab37399133da@mail.gmail.com>
References: <1232669252-21881-1-git-send-email-srabbelier@gmail.com>
	 <7vwscm4xx0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 02:48:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQB9V-0001tE-3j
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 02:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755783AbZAWBqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 20:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755506AbZAWBqo
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 20:46:44 -0500
Received: from rn-out-0910.google.com ([64.233.170.191]:53013 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755468AbZAWBqo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 20:46:44 -0500
Received: by rn-out-0910.google.com with SMTP id k40so919418rnd.17
        for <git@vger.kernel.org>; Thu, 22 Jan 2009 17:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=5TDCI4qnKUvIxCsw46U/EdV8NPjuHZeDxF0BWth27sQ=;
        b=i1WPYH2PTXBcz1F8+pWduNc2Q6PohajIuXzF2ivuRrwHMI6ca42/mg+K4w3B7G9Wxy
         90Rz94LDT8W1P+tGo5x+kpd58OCEEun01bYDuvC+6WU9CJwPgrM7cjOyXH2pC2NFlE1b
         0jXjNn1O+7BwFF4AgjRLlrTP3tCiEm7JpHyVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=PKhTSyOXkWa97vMErM9keCFJet/Wvl9r85iasswdbC2CLW0RpIEa66CeV08kDERhEA
         HGiwa0wkF7SRS9pWAtRMVTdx+xvi21FBtZjZbSLX+jF+bZkOI8iVziR9s7lFvrc+Yq6W
         bXsqM5kreps5VAOMxm3wGkbSq8c83WcDM8v3s=
Received: by 10.151.42.10 with SMTP id u10mr2405155ybj.205.1232675202823; Thu, 
	22 Jan 2009 17:46:42 -0800 (PST)
In-Reply-To: <7vwscm4xx0.fsf@gitster.siamese.dyndns.org>
X-Google-Sender-Auth: 097db7f9f3b5bf71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106821>

On Fri, Jan 23, 2009 at 02:24, Junio C Hamano <gitster@pobox.com> wrote:
> I think the basic idea is Ok, but is it a reliable check at this point to
> see if (refs == NULL) to tell if the target repository is an empty one?

This is the question I asked Dscho, and he said/guessed that it was.

> I am mostly worried about a failure case (connected but couldn't get the
> refs, or perhaps connection failed to start).  If you get a NULL in such a
> case you may end up saying "oh you cloned a void" when you should say
> "nah, such a remote repository does not exist".

Yes, this was my concern as well.

> If transport_get_remote_refs() dies without returning NULL, that would be
> sufficient, but I didn't check.

It does, transport_get_remote_refs() calls fetch_pack, which dies when
'refs' (the fourth argument) is NULL:

static int fetch_refs_via_pack(...) {
// setup code snipped
	if (!data->conn) {
		connect_setup(transport);
		get_remote_heads(data->fd[0], &refs_tmp, 0, NULL, 0, NULL);
	}

	refs = fetch_pack(&args, data->fd, data->conn,
			  refs_tmp ? refs_tmp : transport->remote_refs,
			  dest, nr_heads, heads, &transport->pack_lockfile);

So unless get_remote_heads messes with it, it will remain NULL. Now I
must admit that I'm not familiar enough with get_remote_heads to know
if this could cause a false positive, Dscho?

-- 
Cheers,

Sverre Rabbelier
