From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: Re: [PATCH 2/4] log and rev-list: Fixed newline termination issues with --graph
Date: Mon, 7 Apr 2008 19:25:28 -0500
Message-ID: <5d46db230804071725r44694e76l3d6e63aabc67f372@mail.gmail.com>
References: <1207518444-5955-1-git-send-email-adam@adamsimpkins.net>
	 <1207555281-9362-1-git-send-email-adam@adamsimpkins.net>
	 <1207555281-9362-2-git-send-email-adam@adamsimpkins.net>
	 <7vod8mqdlw.fsf@gitster.siamese.dyndns.org>
	 <7vwsnaoxlz.fsf@gitster.siamese.dyndns.org>
	 <7vmyo5nr2h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org,
	"Adam Simpkins" <adam@adamsimpkins.net>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 02:26:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jj1fI-0006bx-Hd
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 02:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423AbYDHAZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 20:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755472AbYDHAZd
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 20:25:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:64499 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbYDHAZc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 20:25:32 -0400
Received: by nf-out-0910.google.com with SMTP id g13so818394nfb.21
        for <git@vger.kernel.org>; Mon, 07 Apr 2008 17:25:29 -0700 (PDT)
Received: by 10.150.192.7 with SMTP id p7mr3069854ybf.21.1207614328454;
        Mon, 07 Apr 2008 17:25:28 -0700 (PDT)
Received: by 10.150.156.18 with HTTP; Mon, 7 Apr 2008 17:25:28 -0700 (PDT)
In-Reply-To: <7vmyo5nr2h.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: b76147d4440d7ef3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78991>

On Mon, Apr 7, 2008 at 7:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>  >  (2) Presence of %n in "--pretty=format:..." means a multi-line output and
>  >      uses separator as before; lack of %n means it is a one-line format
>  >      and uses terminator.
>
>  After thinking about this a bit more, I think a slight variant of the
>  above probably is the least intrusive both from code and semantics point
>  of view, and would match end-user expectations pretty well.
>
>  This attached patch introduces a single bit "use_terminator" in "struct
>  rev_info", which is normally false (i.e. most formats use separator
>  semantics) but by flipping it to true, you can ask for terminator
>  semantics just like oneline format does.
>
>  The function get_commit_format(), which is what parses "--pretty=" option,
>  now takes a pointer to "struct rev_info" and updates its commit_format and
>  use_terminator fields.  It used to return the value of type "enum
>  cmit_fmt", but all the callers assigned it to rev->commit_format.
>
>  There are only two cases the code turns use_terminator on.  Obviously, the
>  traditional oneline format (--pretty=oneline) is one of them, and the new
>  case is --pretty=format:... that does not end with "%n".
>
>  When the custom format "--pretty=format:" is:
>
>         "A: %an <%ae>%nC: %cn <%ce>%n"
>
>  it represents a record with two lines (author and committer), and these
>  are output with an extra LF in between, just like the regular --pretty
>  without customization will get an extra separator.  The custom format
>
>         "A: %an <%ae> C: %cn <%ce>"
>
>  will give a one-line-per-commit output, each of which is terminated with
>  LF.  And
>
>         "A: %an <%ae>%nC: %cn <%ce>"
>
>  will give two line per commit without extra separator.
>

Hi,

Shouldn't whatever option is used here respect line_terminator such
that it will use NULL bytes when -z is used?  Having watched this
discussion, it seems like you really want an option --whatever that
forces a record terminator between records and, I assume, at the end.
I have not seen anyone suggest it, perhaps I missed it.

-Govind
