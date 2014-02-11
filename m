From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce experimental remote object access mode
Date: Tue, 11 Feb 2014 11:29:15 -0800
Message-ID: <xmqqppmtphx0.fsf@gitster.dls.corp.google.com>
References: <CAJo=hJsO=FBkiOo5fuPbToxE1SR3Lh8oim0eTAR6bH1a-TcdPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 11 20:29:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDJ1M-0007F8-Nx
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 20:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496AbaBKT3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 14:29:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44673 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752998AbaBKT3T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 14:29:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EC4469BCC;
	Tue, 11 Feb 2014 14:29:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bxe7W/WtwtEhkw7hMsJrIvy8RZs=; b=WkpeCz
	Bt2XhiikN9Rxan7DkPQp+E91T0QxhUQhGiPPuJ6asiXKsZiIMQbIcOZAar819uXB
	XwkQX3RzKxBurch9rm+aucbQQHZoNjFH/8HWedCD9v6GLOHppeiKkxPrmVnu+ORg
	leuS5pSyTaVOPHAmc/YoE736tyKTejxC3Mrcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qfYgn+YY+8XWX9iF+o7MGBrCyLl8X9C6
	L84+TOsut8KR27AqCx9uzWgN/usFnWOFeCTgeaEda0aU03vlXmSs9KGpQVMn5+y9
	Kv/oWJY9pODePQpWo8Gk4yZ/zIdyRuCpLY42bIgy86Uln9j0WsquaZZTUiFtXlnp
	o77Yas/tlLQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1217269BC4;
	Tue, 11 Feb 2014 14:29:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22D4869BC3;
	Tue, 11 Feb 2014 14:29:17 -0500 (EST)
In-Reply-To: <CAJo=hJsO=FBkiOo5fuPbToxE1SR3Lh8oim0eTAR6bH1a-TcdPA@mail.gmail.com>
	(Shawn Pearce's message of "Tue, 11 Feb 2014 00:54:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CC1259FC-9352-11E3-B282-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241955>

Shawn Pearce <spearce@spearce.org> writes:

> Why would you do this? Perhaps you need more time in your day
> to consume tea or coffee. Set GIT_RTT and enjoy a beverage.

So the conclusion is that it is not practical to do a lazy fetch if
it is done extremely naively at "we want this object --- wait a bit
and we'll give you" level?

I am wondering if we can do a bit better, like "we want this object
--- wait a bit, ah that's a commit, so it is likely that you may
want the trees and blobs associated with it, too, if not right now
but in a near future, let me push a pack that holds them to you"?

>
> So-not-signed-off-by: this author or anyone else
> ---
>
>   :-)
>
>  sha1_file.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 6e8c05d..9bdcbc3 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -38,6 +38,7 @@ const unsigned char null_sha1[20];
>
>  static const char *no_log_pack_access = "no_log_pack_access";
>  static const char *log_pack_access;
> +static useconds_t rtt;
>
>  /*
>   * This is meant to hold a *small* number of objects that you would
> @@ -436,9 +437,20 @@ void prepare_alt_odb(void)
>   read_info_alternates(get_object_directory(), 0);
>  }
>
> +static void apply_rtt()
> +{
> + if (!rtt) {
> + char *rtt_str = getenv("GIT_RTT");
> + rtt = rtt_str ? strtoul(rtt_str, NULL, 10) * 1000 : 1;
> + }
> + if (rtt > 1)
> + usleep(rtt);
> +}
> +
>  static int has_loose_object_local(const unsigned char *sha1)
>  {
>   char *name = sha1_file_name(sha1);
> + apply_rtt();
>   return !access(name, F_OK);
>  }
>
> @@ -1303,6 +1315,7 @@ void prepare_packed_git(void)
>
>   if (prepare_packed_git_run_once)
>   return;
> +
>   prepare_packed_git_one(get_object_directory(), 1);
>   prepare_alt_odb();
>   for (alt = alt_odb_list; alt; alt = alt->next) {
> @@ -1439,6 +1452,7 @@ static int open_sha1_file(const unsigned char *sha1)
>   struct alternate_object_database *alt;
>
>   fd = git_open_noatime(name);
> + apply_rtt();
>   if (fd >= 0)
>   return fd;
