From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [BUG-ish] diff compaction heuristic false positive
Date: Fri, 10 Jun 2016 10:31:13 +0200
Message-ID: <575A7AD1.50604@alum.mit.edu>
References: <20160610075043.GA13411@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 10:31:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBHqt-00044D-Le
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 10:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbcFJIbf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 04:31:35 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:45934 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750710AbcFJIbd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 04:31:33 -0400
X-AuditID: 1207440d-bb3ff7000000090b-46-575a7ad4b3ed
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 94.F5.02315.4DA7A575; Fri, 10 Jun 2016 04:31:16 -0400 (EDT)
Received: from [192.168.69.130] (p508EAFFC.dip0.t-ipconnect.de [80.142.175.252])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5A8VElI029569
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 10 Jun 2016 04:31:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <20160610075043.GA13411@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsUixO6iqHulKirc4GSXlEXXlW4mi4beK8wW
	uxf3M1v8aOlhtti8uZ3FgdVj56y77B4LNpV6POvdw+hx8ZKyx+dNcgGsUdw2SYklZcGZ6Xn6
	dgncGedOTGMvuMJdsX7uNZYGxoUcXYycHBICJhKf3m5g7WLk4hAS2MoocXBfNxuEc4FJYtup
	S0wgVcIC9hKtq1aB2SICjhJHfk1nA7GFBKwktn3czQpiMwvkSty/cIcFxGYT0JVY1NMMVM/B
	wSugKdF8PAEkzCKgKvG9oQGsVVQgROL8uq1grbwCghInZz4BamXn4BSwlngoADFQXeLPvEvM
	ELa8RPPW2cwTGPlnIWmYhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfRyM0v0
	UlNKNzFCgph3B+P/dTKHGAU4GJV4eBl2RIYLsSaWFVfmHmKU5GBSEuXdGRgVLsSXlJ9SmZFY
	nBFfVJqTWnyIUYKDWUmEd0cZUI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYr
	w8GhJMHbUwnUKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+KxvhiYDyCpHiA9k6q
	ANlbXJCYCxSFaD3FqMtxZP+9tUxCLHn5ealS4rz7QYoEQIoySvPgVsBS1itGcaCPhXk7QS7h
	AaY7uEmvgJYwAS1ZfiQcZElJIkJKqoGx/vL6Tsdzf/Zc+7elIJjx1oknU5ktXX8/NDA+Lqc9
	7ewzOSnX8yJvClgkDjtwaVnvS7ZmkHWfY25lWLYw8tLxefa/0jK6/kVGa7/S+lO7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296958>

On 06/10/2016 09:50 AM, Jeff King wrote:
> I found a false positive with the new compaction heuristic in v2.9:
> [...]
> I get this rather unfortunate diff:
>=20
>     $ git diff
>     diff --git a/file.rb b/file.rb
>     index bd9d1cb..67fbeba 100644
>     --- a/file.rb
>     +++ b/file.rb
>     @@ -1,5 +1,11 @@
>      def foo
>        do_foo_stuff()
>     =20
>     +  common_ending()
>     +end
>     +
>     +def bar
>     +  do_bar_stuff()
>     +
>        common_ending()
>      end

I've often thought that indentation would be a good, fairly universal
signal for diff to use when deciding how to slide hunks around. Most
source code is indented in a way that shows its structure.

I propose the following heuristic:

* Prefer to start and end hunks following lines with the least
  indentation.

* Define the "indentation" of a blank line to be the indentation of
  the previous non-blank line minus epsilon.

* In the case of a tie, prefer to slide the hunk down as far as
  possible.

=46or the case above, the indentations for the candidate "before-the-hu=
nk"
lines and the resulting hunk would be

>      def foo
> 2      do_foo_stuff()
> 2-=CE=B5
> 2      common_ending()
> 0    end
> 0-=CE=B5 +
>     +def bar
>     +  do_bar_stuff()
>     +
>     +  common_ending()
>     +end

I haven't tried testing this heuristic systematically but I have the
feeling that it would be pretty effective and yet quite easy to impleme=
nt.

Michael
