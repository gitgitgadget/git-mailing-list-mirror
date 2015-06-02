From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFCv2 04/16] upload-pack-2: Implement the version 2 of upload-pack
Date: Tue, 02 Jun 2015 11:59:02 -0700
Message-ID: <xmqqfv6a2ayx.fsf@gitster.dls.corp.google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
	<1433203338-27493-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, peff@peff.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 20:59:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzrP5-0000Y8-7p
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 20:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753607AbbFBS7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 14:59:06 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:38482 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357AbbFBS7F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 14:59:05 -0400
Received: by igblz2 with SMTP id lz2so18615110igb.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 11:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Ebg8mkS5AGenFdogcQcGm3zpUw4PjWSlkc8q30mRPW4=;
        b=E6RI0rEVxmrB1UOg0pX9kdxDpsEdbheZ/20j/n6xYvIqmo8gjOcRFuZWZyIZ6Jwj92
         PaDYI8wnDc27n+v3S4D6Y3Oq86Or+7PgMEWgmGB5UYPUTNXFEiBX0pUfzzpTMzqcJiyp
         HbkVDcj5t+qN0J6I6jbOw+Qh8zqIPbtEDakkaheUJ1iKokZElBsJwuo8j1gle60pYCv9
         rK9R2hNtaYFVKttTWPMij8VOPwoZcb5RcmGWzi6GpEM7zfKDPfy3SbvLfQAfM1fsQ3HU
         JJV8Uv1zayoDOyOQnX6X0uA/HJqHv14ew3RHJXQDQ+Fz5UStRj2VFVhevxlhn3U7ucGp
         TnRg==
X-Received: by 10.43.39.208 with SMTP id tn16mr35442261icb.27.1433271544795;
        Tue, 02 Jun 2015 11:59:04 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id r4sm10509776igh.9.2015.06.02.11.59.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 11:59:04 -0700 (PDT)
In-Reply-To: <1433203338-27493-5-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 1 Jun 2015 17:02:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270585>

Stefan Beller <sbeller@google.com> writes:

> Subject: [RFCv2 04/16] upload-pack-2: Implement the version 2 of upload-pack

Nit; s/I/i/, to match others in the series, I think.

> In upload-pack-2 we send each capability in its own packet buffer.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Notes:
>     Moved the capabilities into a struct containing all the capabilities,
>     and then we selectively cancel out unwanted capabilities.

> diff --git a/upload-pack-2.c b/upload-pack-2.c
> new file mode 120000
> index 0000000..e30a871
> --- /dev/null
> +++ b/upload-pack-2.c
> @@ -0,0 +1 @@
> +upload-pack.c
> \ No newline at end of file

Yuck.

Can't we do an equivalent without this symbolic link, i.e. a new
Makefile rule to compile upload-pack.c in two different ways to two
different object files?

The way this patch is organized makes it unclear which part is what
was added for v2 and which part is shared with v1 (and changes can
be possible breakage to the existing code), leading to a patch that
is hard to review.

> diff --git a/upload-pack.c b/upload-pack.c
> index 2493964..7477ca3 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -716,33 +716,69 @@ static void format_symref_info(struct strbuf *buf, struct string_list *symref)
>  		strbuf_addf(buf, " symref=%s:%s", item->string, (char *)item->util);
>  }
>  
> +static int advertise_capabilities = 1;
> +const char *all_capabilities[] = {
> +	"multi_ack",
> +	"thin-pack",
> +	"side-band",
> +	"side-band-64k",
> +	"ofs-delta",
> +	"shallow",
> +	"no-progress",
> +	"include-tag",
> +	"multi_ack_detailed",
> +	"allow-tip-sha1-in-want",
> +	"no-done",
> +};
> +
> +static void send_capabilities(void)

This looks like send-capabilities-v2.  I am OK to share code between
v1 and v2 by having two implementations in the same file and some
(or major part of) helper functions or overall structure code shared
between the two, but if you are taking that route, a version specific
helper like this needs to be made clear which one is which.

> +{
> +	int i;
> +	for (i = 0; i < ARRAY_SIZE(all_capabilities); i++) {
> +		const char *cap = all_capabilities[i];
> +		if (!strcmp(cap, "allow-tip-sha1-in-want") && !allow_tip_sha1_in_want)
> +			continue;
> +		if (!strcmp(cap, "no-done") && !stateless_rpc)
> +			continue;
> +		packet_write(1,"%s", cap);

s/1,/1, /;

>  static int send_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
>  {
> -	static const char *capabilities = "multi_ack thin-pack side-band"
> -		" side-band-64k ofs-delta shallow no-progress"
> -		" include-tag multi_ack_detailed";
> +

And is this one only for v1?

>  	const char *refname_nons = strip_namespace(refname);
>  	unsigned char peeled[20];
>  
>  	if (mark_our_ref(refname, sha1))
>  		return 0;
>  
> -	if (capabilities) {
> -		struct strbuf symref_info = STRBUF_INIT;
> -
> -		format_symref_info(&symref_info, cb_data);
> -		packet_write(1, "%s %s%c%s%s%s%s agent=%s\n",
> -			     sha1_to_hex(sha1), refname_nons,
> -			     0, capabilities,
> -			     allow_tip_sha1_in_want ? " allow-tip-sha1-in-want" : "",
> -			     stateless_rpc ? " no-done" : "",
> -			     symref_info.buf,
> -			     git_user_agent_sanitized());
> -		strbuf_release(&symref_info);
> +	if (advertise_capabilities) {
> +		int i;
> +		struct strbuf capabilities = STRBUF_INIT;
> +
> +		for (i = 0; i < ARRAY_SIZE(all_capabilities); i++) {
> +			const char *cap = all_capabilities[i];
> +			if (!strcmp(cap, "allow-tip-sha1-in-want") && !allow_tip_sha1_in_want)
> +				continue;
> +			if (!strcmp(cap, "no-done") && !stateless_rpc)
> +				continue;
> +			strbuf_addf(&capabilities, " %s", cap);
> +		}
> +
> +		format_symref_info(&capabilities, cb_data);
> +		strbuf_addf(&capabilities, " agent=%s", git_user_agent_sanitized());
> +
> +		packet_write(1, "%s %s%c%s\n", sha1_to_hex(sha1), refname_nons,
> +			     0, capabilities.buf);
> +		strbuf_release(&capabilities);
> +		advertise_capabilities = 0;

The change itself may be going in the right direction, but I'd
suggest doing this in two steps:

 * refactor existing v1 without adding anything v2 specific
   (e.g. send-capabilities above).  A new file-scope global
   all_capabilities[] array, use of it in this new implementation of
   send_ref(), and introduction of the separate
   advertise_capabilities bool, are good examples of refactoring of
   v1.

 * then on top of that solid foundation, add v2 specific stuff.
