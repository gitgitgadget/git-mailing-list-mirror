From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/9] git-cat-file: Add --stdin option
Date: Fri, 26 Oct 2007 13:59:24 -0700
Message-ID: <7vd4v1y4lv.fsf@gitster.siamese.dyndns.org>
References: <1193307927-3592-1-git-send-email-aroben@apple.com>
	<1193307927-3592-2-git-send-email-aroben@apple.com>
	<1193307927-3592-3-git-send-email-aroben@apple.com>
	<1193307927-3592-4-git-send-email-aroben@apple.com>
	<1193307927-3592-5-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brian Downing <bdowning@lavos.net>
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 22:59:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlWHP-0000NV-UG
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 22:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756408AbXJZU7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 16:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754974AbXJZU7c
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 16:59:32 -0400
Received: from rune.pobox.com ([208.210.124.79]:52702 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754560AbXJZU7b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 16:59:31 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id BA1F1150A04;
	Fri, 26 Oct 2007 16:59:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id E1F241509EA;
	Fri, 26 Oct 2007 16:59:48 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62441>

Adam Roben <aroben@apple.com> writes:

> @@ -23,6 +23,10 @@ OPTIONS
>  	For a more complete list of ways to spell object names, see
>  	"SPECIFYING REVISIONS" section in gitlink:git-rev-parse[1].
>  
> +--stdin::
> +	Read object names from stdin instead of specifying one on the
> +	command line.
> +

This does not talk about modified output format: what the format
is, nor when that modified format is used.

> @@ -139,16 +139,26 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>  	if (!buf)
>  		die("git-cat-file %s: bad file", obj_name);
>  
> +	if (print_size) {
> +		printf("%lu\n", size);
> +		fflush(stdout);
> +	}
>  	write_or_die(1, buf, size);
> +	if (print_size) {
> +		printf("\n");
> +		fflush(stdout);
> +	}
>  	return 0;
>  }
>  

Not that I object strongly to it, but do we need extra LF after
the contents?

  - "It would help readers written in typical scripting
    languages" is an acceptable answer, but I doubt that is the
    case --- the reader is given the number of bytes and is
    going to "read($pipe, $buf, $that_size)" anyway.

  - "The reader can assert that one-byte past the content is a
    LF to catch errors, and this LF would help re-synchronize
    after such an error" would be another acceptable answer, but
    for the re-synchronization to work, the output needs to tell
    which record each chunk is about (i.e. if the output were
    "<type> <sha1> <size>LF<contents>LF", the "re-sync" argument
    would make a bit more sense).

> +	print_size = !opt || opt == 'p';

Needs a bit of comment here, and in the documentation.  E.g.

	git-cat-file --stdin -t <list-of-sha1
        git-cat-file --stdin -s <list-of-sha1

	are ways to check types and sizes of the objects in the
	list.

How does --stdin interact with -e?

How does --stdin interact with -p when printing a tree or a tag
object?

How does "blob --stdin" do when input sequence contains a non
blob SHA1?

It almost feels that --stdin should be named something else,
such as --batch or --bulk, as it is not just affecting the
input.

Here is an alternative suggestion.

   Two new options, --batch and --batch-check, are introduced.
   These options are incompatible with -[tsep] or an object type
   given as the first parameter to git-cat-file.

   * git-cat-file --batch-check <list-of-sha1

     outputs a record of this form

          <sha1> SP <type> SP <size> LF

     for each of the input lines.

   * git-cat-file --batch <list-of-sha1

     outputs a record of this form

          <sha1> SP <type> SP <size> LF <contents> LF

     for each of the input lines.

  For a missing object, either option gives a record of form:

          <sha1> SP missing LF
