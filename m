From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] removes the artificial restriction tagsize < 8kb from git-mktag
Date: Mon, 22 May 2006 12:19:33 -0700
Message-ID: <7v1wulc1fe.fsf@assigned-by-dhcp.cox.net>
References: <4471CF5A.702@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 21:19:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiFwH-0007Pn-Ta
	for gcvg-git@gmane.org; Mon, 22 May 2006 21:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWEVTTf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 22 May 2006 15:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWEVTTf
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 15:19:35 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:12470 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751077AbWEVTTe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 15:19:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060522191933.VSTU27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 22 May 2006 15:19:33 -0400
To: =?iso-8859-1?Q?Bj=F6rn?= Engelmann <BjEngelmann@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20522>

Bj=F6rn Engelmann <BjEngelmann@gmx.de> writes:

> @@ -154,6 +154,7 @@ extern int ce_match_stat(struct cache_en
>  extern int ce_modified(struct cache_entry *ce, struct stat *st, int)=
;
>  extern int ce_path_match(const struct cache_entry *ce, const char
> **pathspec);
>  extern int index_fd(unsigned char *sha1, int fd, struct stat *st, in=
t
> write_object, const char *type);
> +extern int read_pipe(int fd, char** return_buf, unsigned long*
> return_size);
>  extern int index_pipe(unsigned char *sha1, int fd, const char *type,
> int write_object);

I smell whitespace breakage around here...

> diff --git a/mktag.c b/mktag.c
> index 2328878..79c466c 100644
> --- a/mktag.c
> +++ b/mktag.c
>...
> @@ -114,21 +114,24 @@ int main(int argc, char **argv)
> =20
>      setup_git_directory();
> =20
> -    // Read the signature
> -    size =3D 0;
> -    for (;;) {
> -        int ret =3D xread(0, buffer + size, MAXSIZE - size);
> -        if (ret <=3D 0)
> -            break;
> -        size +=3D ret;
> +    if (read_pipe(0, &buffer, &size)) {
> +        free(buffer);
> +        die("could not read from stdin");
>      }
> -
> +   =20

Please do not introduce lines with trailing whitespaces.

>      // Verify it for some basic sanity: it needs to start with "obje=
ct
> <sha1>\ntype\ntagger "
> -    if (verify_tag(buffer, size) < 0)
> +    if (verify_tag(buffer, size) < 0) {
> +        free(buffer);
>          die("invalid tag signature file");
> +    }

You seem to be striving for extra cleanliness, but I personally
consider it is not worth calling free() immediately before you
call die().

> =20
> -    if (write_sha1_file(buffer, size, tag_type, result_sha1) < 0)
> +    if (write_sha1_file(buffer, size, tag_type, result_sha1) < 0) {
> +        free(buffer);
>          die("unable to write tag file");
> +    }
> +       =20
> +    free(buffer);
> +   =20
>      printf("%s\n", sha1_to_hex(result_sha1));
>      return 0;
>  }

A call to free() immediately before returning from main() might
look similar to the die() issue I mentioned above, but we might
extend it to do a lot more after writing the tag in the future,
so this one is very good to keep.
