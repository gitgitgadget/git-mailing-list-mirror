From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 3/5] cat-file: teach cat-file a '--allow-unknown-type' option
Date: Wed, 29 Apr 2015 07:52:32 -0700
Message-ID: <xmqqpp6nt2a7.fsf@gitster.dls.corp.google.com>
References: <5540D397.8020104@gmail.com>
	<1430312006-23323-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 16:52:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnTLr-0006u6-NI
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 16:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423327AbbD2Owh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 10:52:37 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53202 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423161AbbD2Owf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 10:52:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D85524BED7;
	Wed, 29 Apr 2015 10:52:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tA8Mu5Nx+vO70PxLG9WBcYbyKrY=; b=eABcI/
	FSy40IH2RITYrjhAqZP3TZNRnqBFN2grFcevLGxCYrpIBvyBQxKN2dApbZB01Hju
	O4qoMbZwOrdfD+eW6bBopERDypEvSR2vPGQtztflGE5/JBKnYtqIc+Pm4P394WYz
	1zoxYFD/fnxmKRVdrXIGeEHf4zBNXM5fDnqSs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DQvQxjWJiMO/G07Jfybtfe8sUVRG+aCA
	yYwYWA87E6UDTZpQS5dtMuMxvMeAaBbYHtg5oPiFlXJ8n98GMUafqMvseJYY6Luy
	ikfc9q5RbYS3Haj/5wZ35fiC+1fuWUrJsECHORoJLnDWhwkHvMzTP5DKhOh6AN3N
	s53qfNo7I9g=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D19B74BED6;
	Wed, 29 Apr 2015 10:52:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD0F04BED5;
	Wed, 29 Apr 2015 10:52:33 -0400 (EDT)
In-Reply-To: <1430312006-23323-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Wed, 29 Apr 2015 18:23:26 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5E5044AE-EE7F-11E4-B1AE-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267968>

Karthik Nayak <karthik.188@gmail.com> writes:

> Currently 'git cat-file' throws an error while trying to
> print the type or size of a broken/corrupt object. This is
> because these objects are usually of unknown types.
>
> Teach git cat-file a '--allow-unkown-type' option where it prints
> the type or size of a broken/corrupt object without throwing
> an error.

Drop "Currently" from the description of the problem you are
solving.  We know that the problem you have to solve in the code is
current without being told.  This comment applies to all patches.

> Modify '-t' and '-s' options to call sha1_object_info_extended()
> directly to support the '--allow-unkown-type' option.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  builtin/cat-file.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 53b5376..299e2e5 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -9,13 +9,20 @@
>  #include "userdiff.h"
>  #include "streaming.h"
>  
> -static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
> +static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
> +			int unkown_type)
>  {
>  	unsigned char sha1[20];
>  	enum object_type type;
>  	char *buf;
>  	unsigned long size;
>  	struct object_context obj_context;
> +	struct object_info oi = {NULL};
> +	struct strbuf sb = STRBUF_INIT;
> +	unsigned flags = LOOKUP_REPLACE_OBJECT;
> +
> +	if (unkown_type)
> +		flags |= LOOKUP_UNKNOWN_OBJECT;
>  
>  	if (get_sha1_with_context(obj_name, 0, sha1, &obj_context))
>  		die("Not a valid object name %s", obj_name);
> @@ -23,20 +30,22 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>  	buf = NULL;
>  	switch (opt) {
>  	case 't':
> -		type = sha1_object_info(sha1, NULL);
> -		if (type > 0) {
> -			printf("%s\n", typename(type));
> +		oi.typename = &sb;
> +		if (sha1_object_info_extended(sha1, &oi, flags) < 0)
> +			die("git cat-file: could not get object info");
> +		if (sb.len) {
> +			printf("%s\n", sb.buf);
> +			strbuf_release(&sb);
>  			return 0;
>  		}
>  		break;
>  
>  	case 's':
> -		type = sha1_object_info(sha1, &size);
> -		if (type > 0) {
> -			printf("%lu\n", size);
> -			return 0;
> -		}
> -		break;
> +		oi.sizep = &size;
> +		if (sha1_object_info_extended(sha1, &oi, flags) < 0)
> +			die("git cat-file: could not get object info");
> +		printf("%lu\n", size);
> +		return 0;
>  
>  	case 'e':
>  		return !has_sha1_file(sha1);
> @@ -323,7 +332,7 @@ static int batch_objects(struct batch_options *opt)
>  }
>  
>  static const char * const cat_file_usage[] = {
> -	N_("git cat-file (-t | -s | -e | -p | <type> | --textconv) <object>"),
> +	N_("git cat-file (-t [--allow-unkown-type]|-s [--allow-unkown-type]|-e|-p|<type>|--textconv) <object>"),
>  	N_("git cat-file (--batch | --batch-check) < <list-of-objects>"),
>  	NULL
>  };
> @@ -359,6 +368,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>  	int opt = 0;
>  	const char *exp_type = NULL, *obj_name = NULL;
>  	struct batch_options batch = {0};
> +	int unkown_type = 0;
>  
>  	const struct option options[] = {
>  		OPT_GROUP(N_("<type> can be one of: blob, tree, commit, tag")),
> @@ -369,6 +379,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>  		OPT_CMDMODE('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
>  		OPT_CMDMODE(0, "textconv", &opt,
>  			    N_("for blob objects, run textconv on object's content"), 'c'),
> +		OPT_BOOL( 0, "allow-unkown-type", &unkown_type,
> +			  N_("allow -s and -t to work with broken/corrupt objects")),
>  		{ OPTION_CALLBACK, 0, "batch", &batch, "format",
>  			N_("show info and content of objects fed from the standard input"),
>  			PARSE_OPT_OPTARG, batch_option_callback },
> @@ -402,5 +414,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>  	if (batch.enabled)
>  		return batch_objects(&batch);
>  
> -	return cat_one_file(opt, exp_type, obj_name);
> +	if (unkown_type && opt != 't' && opt != 's')
> +		die("git cat-file --allow-unkown-type: use with -s or -t");
> +	return cat_one_file(opt, exp_type, obj_name, unkown_type);
>  }
