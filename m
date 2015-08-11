From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 02/13] ref-filter: print output to strbuf for formatting
Date: Tue, 11 Aug 2015 10:56:29 -0700
Message-ID: <xmqqlhdhso8i.fsf@gitster.dls.corp.google.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
	<1439129506-9989-3-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 19:56:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPDmu-0001v9-Hh
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 19:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbbHKR4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 13:56:32 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35502 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbbHKR4c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 13:56:32 -0400
Received: by pdrg1 with SMTP id g1so86058320pdr.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 10:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=vZwW/+log5SgmubGOl6+Og6UVPLGh+qErncI/y7ToMI=;
        b=XOsTB90anWIhvWdcogtuISKFrOOrpAExGr06TqPso90cPMl0SI89ECg8jJT0BqhwZx
         qzPsEiH4XvDZcMjRc6awMS1hqz5FqUe9V09FpJj0YPu5eOW0oJJv1ORv4Hir0o80VGc2
         mI3GgM2I+7zSatODdGiXRiKzdzai7Z/YmAPrQvUdTH2h0jLn3y6YpTUH3jUPuw+oRt4j
         Q9PV4dPBmoBlFDUuDHa/Anx1qFEzdA4/9IR8QMeeoKbEEKFlJzRNnL6VOTkz4Ox0vgzK
         144OFQOG6GAqyL/fNyt6FHh4JmImNri0DPUvCW1RfQDSztzMN7KubYpHuy8FdAY1+DxT
         Rd6Q==
X-Received: by 10.70.43.15 with SMTP id s15mr59232294pdl.14.1439315791629;
        Tue, 11 Aug 2015 10:56:31 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id gk5sm3460878pac.21.2015.08.11.10.56.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 10:56:30 -0700 (PDT)
In-Reply-To: <1439129506-9989-3-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Sun, 9 Aug 2015 19:41:35 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275701>

Karthik Nayak <karthik.188@gmail.com> writes:

> -static void print_value(struct atom_value *v, int quote_style)
> +static void format_quote_value(struct atom_value *v, int quote_style, struct strbuf *output)
>  {

Hmph...

> -static void emit(const char *cp, const char *ep)
> +static void append_non_atom(const char *cp, const char *ep, struct strbuf *output)

I was tempted to suggest s/non_atom/literal/, but this would do for now...

> @@ -1262,19 +1257,20 @@ static void emit(const char *cp, const char *ep)
>  void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
>  {
>  	const char *cp, *sp, *ep;
> +	struct strbuf output = STRBUF_INIT;
>  
>  	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
>  		struct atom_value *atomv;
>  
>  		ep = strchr(sp, ')');
>  		if (cp < sp)
> -			emit(cp, sp);
> +			append_non_atom(cp, sp, &output);
>  		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
> -		print_value(atomv, quote_style);
> +		format_quote_value(atomv, quote_style, &output);

If the one to add a literal string (with %hex escaping) is called "append_",
then this should be called append_quoted_atom() or something, no?
