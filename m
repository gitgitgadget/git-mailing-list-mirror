From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] Don't try to reclose in command_close_bidi_pipe
Date: Fri, 30 Jan 2009 22:35:54 +0800
Message-ID: <be6fef0d0901300635v4e6009f1n7da405ebc4c8dd68@mail.gmail.com>
References: <1233291570-23295-1-git-send-email-nothingmuch@woobling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yuval Kogman <nothingmuch@woobling.org>
X-From: git-owner@vger.kernel.org Fri Jan 30 15:37:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSuUq-0007vy-Py
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 15:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588AbZA3Of5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 09:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753475AbZA3Of4
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 09:35:56 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:62768 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbZA3Ofz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 09:35:55 -0500
Received: by wa-out-1112.google.com with SMTP id v33so224960wah.21
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 06:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OE8bCwhVIxHos243Pb8jTc63ug7SH9PIzjjwzFOTaNk=;
        b=cC9JM7LmjttlxGwV0fo2/Hah7de0GhZbITGeyyfCcSCvokaNtlIYhnmgac5sEOI7ve
         YoxDSwb+iyg5OzcvabbNPbCcSu0JBiFlWwnRgkJ8dsFo7yJBavwvodJcmikIZPLvy7Fe
         TUvvyTz8XKO7D+z7BIDmoTM3OKtqygorElXw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YR3JpjZY6o+Naxx/wj+4r85pSxbXnlrqaS5WmN997UzKTeNVzXaiyvG6MX5Xcmyrf2
         jQVw71Dl3f37cGDZVmRisTJTMlwkmrfUmGuB5IUqz1acPXH+JcdvyFucIpavmPwyTrl8
         ybgTUS2g7/vBaBykOIZSENAuhFm5ZEZv3Rxu0=
Received: by 10.115.54.7 with SMTP id g7mr824016wak.95.1233326154217; Fri, 30 
	Jan 2009 06:35:54 -0800 (PST)
In-Reply-To: <1233291570-23295-1-git-send-email-nothingmuch@woobling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107827>

Hi,

On Fri, Jan 30, 2009 at 12:59 PM, Yuval Kogman <nothingmuch@woobling.org> wrote:
> Some commands require their standard input to be closed (like
> git-commit-tree). This patch changes command_close_bidi_pipe so no
> longer tries to close already closed handles, resulting in an error.

>From this message, you seem to intend this as a fix. Can you tell us
how one might go about to reproduce this issue?

> ---
>  perl/Git.pm |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/perl/Git.pm b/perl/Git.pm
> index 7d7f2b1..283bba8 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -422,6 +422,7 @@ sub command_close_bidi_pipe {
>        local $?;
>        my ($pid, $in, $out, $ctx) = @_;
>        foreach my $fh ($in, $out) {
> +               next unless defined(fileno($fh));

Quoting the perldoc for fileno at http://perldoc.perl.org/functions/fileno.html

"(Filehandles connected to memory objects via new features of open may
return undefined even though they are open.)"

Is "unless defined(fileno($fh))" a reliable way to check if the handle
is closed?

-- 
Cheers,
Ray Chuan
