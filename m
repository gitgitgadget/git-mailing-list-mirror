From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/5] http: handle proxy proactive authentication
Date: Mon, 09 Apr 2012 17:59:13 -0700
Message-ID: <7vsjgcs8pq.fsf@alter.siamese.dyndns.org>
References: <4F5F53CA.7090003@seap.minhap.es>
 <7v398cvb30.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, sam@vilain.net,
	spearce@spearce.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Tue Apr 10 02:59:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHPQX-0004fR-LV
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 02:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146Ab2DJA7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 20:59:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64882 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932124Ab2DJA7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 20:59:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 665C06C61;
	Mon,  9 Apr 2012 20:59:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s5o1vZ+EjSEpK2Pl18CgRvb3I0Q=; b=MXMnf7
	97toh2LaQC9xuG0DcuEvBq/UtuCXLJNsXD6H7diYhLxi90yN5zcLxJUmYjEwsmKD
	U0cKSE1yPRDxOlDun9ZRC9g/ankCM2Cthhylb80qywPpfTycfI+CM8ehiqpEsNGd
	0DMpWWdWqfqtsws+S8Wuo6w/I9diJN6U3ofvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=McEg/x69oUgrvHcUVMPqgB+N2N9dNwya
	mBtUH0PaIr5anRCJu5cJnpV2Z7T8LrKR/Cy/0LJH6mWz+RS/CCXG+OdcQ1BBN8Sk
	N0q72M0/rnKXoc9hVbhoqEzbq3PM0cGB+5G/d7qEpibWvSJH8Pz2hrt5pawa256I
	3FXMELwD2so=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C3D36C60;
	Mon,  9 Apr 2012 20:59:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D734B6C5E; Mon,  9 Apr 2012
 20:59:14 -0400 (EDT)
In-Reply-To: <7v398cvb30.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 09 Apr 2012 14:39:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 646EDD50-82A8-11E1-B885-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195053>

Junio C Hamano <gitster@pobox.com> writes:

> I haven't formed an opinion on what the proper solution should be, but
> either the credential_from_url() function needs to be updated to accept
> the scp style [user@]<host>:<port> argument, or this specific caller
> should take the responsibility to do special case the syntax.

Well, calling the above "scp" style is a mistake (it is not scp style at
all), but the patch to teach the credentail_from_url() to handle the proxy
specification may look like this:

 credential.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/credential.c b/credential.c
index 62d1c56..482ae88 100644
--- a/credential.c
+++ b/credential.c
@@ -324,11 +324,13 @@ void credential_from_url(struct credential *c, const char *url)
 	 *   (1) proto://<host>/...
 	 *   (2) proto://<user>@<host>/...
 	 *   (3) proto://<user>:<pass>@<host>/...
+	 * or "proto://"-less variants of the above for *_proxy variables.
 	 */
 	proto_end = strstr(url, "://");
-	if (!proto_end)
-		return;
-	cp = proto_end + 3;
+	if (proto_end)
+		cp = proto_end + 3;
+	else
+		cp = url;
 	at = strchr(cp, '@');
 	colon = strchr(cp, ':');
 	slash = strchrnul(cp, '/');
@@ -348,7 +350,7 @@ void credential_from_url(struct credential *c, const char *url)
 		host = at + 1;
 	}
 
-	if (proto_end - url > 0)
+	if (proto_end && proto_end != url)
 		c->protocol = xmemdupz(url, proto_end - url);
 	if (slash - host > 0)
 		c->host = url_decode_mem(host, slash - host);
