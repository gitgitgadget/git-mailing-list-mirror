From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH 5/3] Alternative --dirstat implementation, based on
 diffstat analysis
Date: Tue, 12 Apr 2011 07:46:47 -0700
Message-ID: <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com>
References: <7vtye834al.fsf@alter.siamese.dyndns.org> <7vwrj0sap3.fsf@alter.siamese.dyndns.org>
 <201104121122.56870.johan@herland.net> <201104121126.49881.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Apr 12 16:47:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9esg-00089m-M0
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 16:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376Ab1DLOri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 10:47:38 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52625 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932329Ab1DLOrh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2011 10:47:37 -0400
Received: from mail-iy0-f174.google.com (mail-iy0-f174.google.com [209.85.210.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p3CEl7cG022437
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Tue, 12 Apr 2011 07:47:07 -0700
Received: by iyb14 with SMTP id 14so6693687iyb.19
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 07:47:07 -0700 (PDT)
Received: by 10.231.119.216 with SMTP id a24mr6986580ibr.58.1302619627064;
 Tue, 12 Apr 2011 07:47:07 -0700 (PDT)
Received: by 10.231.33.199 with HTTP; Tue, 12 Apr 2011 07:46:47 -0700 (PDT)
In-Reply-To: <201104121126.49881.johan@herland.net>
X-Spam-Status: No, hits=-103.481 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171394>

On Tue, Apr 12, 2011 at 2:26 AM, Johan Herland <johan@herland.net> wrote:
> This patch adds an alternative implementation of show_dirstat(), called
> show_dirstat_based_on_diffstat(), which uses the more expensive diffstat
> analysis (as opposed to --dirstat's own (inexpensive) analysis) to derive
> the numbers from which the --dirstat output is computed.
>
> The alternative implementation is controlled by a new config variable called
> diff.dirstatBasedOnDiffstat.

So I don't hate the idea, but I do hate the "use a config option"
part. Or rather, I hate the fact that it's the _only_ way to do it
(and the particular config name you chose).

I'd much rather have a command line option for the two cases, and then
have the config file part be a way to perhaps set the default value.

Something like "--dirstat=exact", and then without the explicit
setting you might fall back on the config file.

(One reason I'd like that is that I think the "--cumulative" option
was a mistake. Again, it _should_ have been another option to
"--dirstat", rather than a stand-alone option that makes no sense on
its own)

So in a better world, I think we should be able to write

  --dirstat=[non]exact,[non]cumulative,1

to say exactly what kind of dirstat we actually want. And the config
options would also match, iow

  [dirstat]
     exact = true
     cumulative = true
     percentage = 1

rather than the cumbersome name you chose that is based on an
implementation issue rather than a user interface issue (I think
config options should talk about the user experience more than about
how it was implemented, so "diff.dirstatbasedondiffstat: is not
wonderful)

Wouldn't that be nicer? Can I sucker you into parsing something like that?

If you do this, another thing I've occasionally wanted to see was a
percentage that allows fractional percentages. We show the results in
permille, after all, it should be possible to ask for cut-offs at the
same precision, ie "1.5%".

                 Linus "can I find a sucker to implement this" Torvalds
