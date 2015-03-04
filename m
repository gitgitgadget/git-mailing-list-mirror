From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] diff --shortstat --dirstat: remove duplicate output
Date: Wed, 4 Mar 2015 04:07:35 -0500
Message-ID: <20150304090734.GA31245@peff.net>
References: <xmqqegp9gyof.fsf@gitster.dls.corp.google.com>
 <1425195546-15637-1-git-send-email-marten.kongstad@gmail.com>
 <54F2E931.7020200@web.de>
 <20150301155818.GA5307@laptop>
 <20150302020009.Horde.9sATpKnsrWQkGadaRTvxkA3@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?M=C3=A5rten?= Kongstad <marten.kongstad@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, gitster@pobox.com, johan@herland.net
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Mar 04 10:07:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT5HV-00069b-49
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 10:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760626AbbCDJHn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2015 04:07:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:56127 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759255AbbCDJHj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 04:07:39 -0500
Received: (qmail 28450 invoked by uid 102); 4 Mar 2015 09:07:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Mar 2015 03:07:39 -0600
Received: (qmail 28710 invoked by uid 107); 4 Mar 2015 09:07:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Mar 2015 04:07:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Mar 2015 04:07:35 -0500
Content-Disposition: inline
In-Reply-To: <20150302020009.Horde.9sATpKnsrWQkGadaRTvxkA3@webmail.informatik.kit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264736>

On Mon, Mar 02, 2015 at 02:00:09AM +0100, SZEDER G=C3=A1bor wrote:

> It's not just 'grep -c' but the 'test' checking its output as well.
>=20
> If something goes wrong and the line count doesn't match expectations
> 'test' fails silently leaving the developer clueless as to what went
> wrong.
>=20
> 'test_line_count', on the other hand, produces useful output in case
> of a failure:
>=20
>    $ printf 'foo\nbar\n' >actual
>    $ test_line_count =3D 1 actual
>    test_line_count: line count for actual !=3D 1
>    foo
>    bar

Since we have test_line_count, I think it makes sense to use it. But fo=
r
reference, I recently introduced the `verbose` function to test-lib.sh,
which lets you write:

  $ verbose test 1 =3D 2
  command failed:  'test' '1' '=3D' '2'

You can use it with any command that might fail without printing a
useful error message. The big downside is that it sees only the
arguments to the command, so if you write:

  $ test "$(do_something)" =3D 123

you will only see:

  command failed:  'test '456' '=3D' '123'

with no notion that $(do_something) was involved. So purpose-built
helpers like test_line_count will produce better output.

You may also be introduced in the "-x" option I recently introduced,
which can help with "quiet" failures. E.g.:

  $ ./t0001-init.sh -x --verbose-only=3D15
  [...]
  ok 13 - GIT_DIR & GIT_WORK_TREE (2)
  ok 14 - reinit
 =20
  expecting success:=20
          mkdir template-source &&
          echo content >template-source/file &&
          git init --template=3D../template-source template-custom &&
          test_cmp template-source/file template-custom/.git/file
 =20
  + mkdir template-source
  + echo content
  + git init --template=3D../template-source template-custom
  Initialized empty Git repository in /home/peff/compile/git/t/trash di=
rectory.t0001-init/template-custom/.git/
  + test_cmp template-source/file template-custom/.git/file
  + diff -u template-source/file template-custom/.git/file
  ok 15 - init with --template
  ok 16 - init with --template (blank)

(ok, it's not that interesting because the test didn't fail, but
hopefully you get the point).

Now I'll stop hijacking your thread to advertise random test-lib
features. :)

-Peff
