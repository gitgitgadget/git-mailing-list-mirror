From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 8/8] Add SVN dump parser
Date: Thu, 15 Jul 2010 14:52:06 -0500
Message-ID: <20100715195206.GE2774@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <1279210984-31604-9-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 21:53:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZUUQ-0006YV-JS
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 21:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934580Ab0GOTw5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jul 2010 15:52:57 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42691 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934552Ab0GOTw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 15:52:56 -0400
Received: by pwi5 with SMTP id 5so434736pwi.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 12:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=FbleV3WjUcW3vsPI2BPjMnMzC3d7zBfMtU6JH5oT/Po=;
        b=CqetlgJNqCsULxKynSHPDQyOEHr5UEMrj3VPWrXwhGAit6/Y6bgiO+vBq0JkL45qLc
         GL59CWF02uLITHDuAwGc482cBl3CHt1BmNOhu4kyG4jcx8jCfigLv1H554ZsNwSElyXU
         eevRcCcd6L03ff3gJ4icDeoYSWAjx/X1TyzNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Vl4gSxpOsG2keK8h+Bp4/lwyb9bRWmdykWw+m1/jJRnnGbLKPa07cdgbFXrM0SFp8f
         GtLTmJb7gzbO8zUMbJuRumWW66hzeEICFQVFk1xK/iJ2KLYcUCb6hk85TMpvRp6c4vwZ
         um7OMvW2SUuRCGBfV0Gqz3kmsKuMDQxOyEk9o=
Received: by 10.114.59.15 with SMTP id h15mr956791waa.209.1279223575971;
        Thu, 15 Jul 2010 12:52:55 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id n32sm9073558wag.11.2010.07.15.12.52.54
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 12:52:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1279210984-31604-9-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151118>

Ramkumar Ramachandra wrote:

> svndump parses data that is in SVN dumpfile format produced by
> `svnadmin dump` with the help of line_buffer and uses repo_tree and
> fast_export to emit a git fast-import stream.

Probably worth mentioning the this requires a dumpfile v2 (i.e., it
does not understand the svndiff0 delta format yet).

> +/* Create memory pool for log messages */
> +obj_pool_gen(log, char, 4096);
> +
> +static char* log_copy(uint32_t length, char *log)
> +{
> +	char *buffer;
> +	log_free(log_pool.size);
> +	buffer =3D log_pointer(log_alloc(length));
> +	strncpy(buffer, log, length);
> +	return buffer;
> +}

A strbuf would do just as well.  But using obj_pool looks like a fine
way to avoid depending on another piece of git code.

> +static struct {
> +	uint32_t svn_log, svn_author, svn_date, svn_executable, svn_special=
, uuid,
> +		revision_number, node_path, node_kind, node_action,
> +		node_copyfrom_path, node_copyfrom_rev, text_content_length,
> +		prop_content_length, content_length;
> +} keys;

Neat.  This is a textbook example of where to use a perfect hash, but
comparing interned strings is simpler and fast enough (and the
bottlenecks are elsewhere).

> +static void read_props(void)
[...]
> +			if (key =3D=3D keys.svn_log) {
> +				/* Value length excludes terminating nul. */
> +				rev_ctx.log =3D log_copy(len + 1, val);
> +			} else if (key =3D=3D keys.svn_author) {
> +				rev_ctx.author =3D pool_intern(val);
> +			} else if (key =3D=3D keys.svn_date) {
> +				if (parse_date_basic(val, &rev_ctx.timestamp, NULL))
> +					fprintf(stderr, "Invalid timestamp: %s\n", val);
> +			} else if (key =3D=3D keys.svn_executable) {
> +				node_ctx.type =3D REPO_MODE_EXE;
> +			} else if (key =3D=3D keys.svn_special) {
> +				node_ctx.type =3D REPO_MODE_LNK;
> +			}
> +			key =3D ~0;

Unknown properties are ignored.  Adding stream comments to allow
recovering them is left as an exercise for the interested reader.

> +static void handle_node(void)
> +{

A simple reader does not cope well with this kind of function.  It is
hard to know if it exhaustively deals with all cases.

But: with real-world repos (e.g. ASF) it works well enough.

> +void svndump_read(char *url)
> +{

Too long.  I realize that writing a state machine can be hard in C;
maybe it would be easiest to package up the state in a struct and
have a separate function for the main loop body.

The patches I didn=E2=80=99t comment on all look good.  I don=E2=80=99t=
 think anything I did
comment on should prevent this reaching a wider audience.

Thanks for the pleasant read,
Jonathan
