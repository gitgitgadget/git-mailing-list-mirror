From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 03/10] config: Make git_config() more flexible
Date: Wed, 18 Feb 2009 23:30:39 +0200
Message-ID: <94a0d4530902181330o298fce1am31d9d15145956d78@mail.gmail.com>
References: <1234878776-13250-1-git-send-email-felipe.contreras@gmail.com>
	 <1234878776-13250-2-git-send-email-felipe.contreras@gmail.com>
	 <1234878776-13250-3-git-send-email-felipe.contreras@gmail.com>
	 <7viqn7v47s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 22:32:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZu1b-0006Lj-Bj
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 22:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757AbZBRVan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 16:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106AbZBRVam
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 16:30:42 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:63897 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbZBRVam (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 16:30:42 -0500
Received: by bwz5 with SMTP id 5so291054bwz.13
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 13:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+It/OGaXZ+tVQ0pa/AB0XQwvAQHkVLr5TFNt7a60RE8=;
        b=UiBkoka3/RFiEIAEW66zNi8dU9rYv3wl43Jwj9FWaDxe1Ctt8Ox9kttx16/WpqCdF4
         GA/pIl7WSHAKxCY9Ipd/yFkBmQr4QPtsMtZUeJa3x+yLsKsJ5YbB8IVMxC/L4T3PLfle
         eVZB3BLe5Jcgk7ZLEH6eDGAcaihl9/NIwfolM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JOvkUMTBiuv/jCdWeNWTjapkhkkb/IPM3QXjOsRqkJ4/D3SdUCGf9kqzQdQ6y7aWh9
         UcJjXfjxOBgSHcBkbqSToDOiLtNBpyNQswBndQockhyT1MjSL41DzhKt6j8AbpsR8AWw
         +jL2O7LQTx4YSnbO1je1eMLPXsLNt014jp+Sk=
Received: by 10.181.137.17 with SMTP id p17mr606095bkn.163.1234992639890; Wed, 
	18 Feb 2009 13:30:39 -0800 (PST)
In-Reply-To: <7viqn7v47s.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110580>

On Wed, Feb 18, 2009 at 11:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Currently git_config() returns an error if there is no repo config file
>> available (cwd is not a git repo); it will correctly parse the system
>> and global config files, but still return an error.
>
> Currently it does???
>
> Here is what I get from using the command from master and next:
>
>    $ cd /var/tmp
>    $ ls -d /.git /var/.git /var/tmp/.git /var/tmp/config
>    ls: /.git: No such file or directory
>    ls: /var/.git: No such file or directory
>    ls: /var/tmp/.git: No such file or directory
>    ls: /var/tmp/config: No such file or directory
>    $ git config -l >/dev/null ; echo $?
>    0
>    $ git config alias.co; echo $?
>    checkout
>    0

This patch doesn't alter the behavior of 'git config', it's for
git_config() (the function). At this point cmd_config() will return an
exit code of 0 even if there's an error on git_config() when no
exclusive file is specified.

> I have $HOME/.gitconfig (where the alias comes from) and no system wide
> configuration file.
>
> Also the patch is mistitled.  Whatever you are trying to say about the
> current problem which I do not seem to get, and whatever different
> behaviour from the current one you are trying to implement (which is not
> quite clear from the above log message), it is not about making it more
> flexible.
>
> The patch text suggests you are trying to change the function's exit
> status so the title would be "git-config: report errors correctly in its
> exit status", but it is unspecified in your commit log message what
> definition of "correctly" you are using in this patch.

What I'm trying to do is "Make git_config() don't return an error when
there's no repo config file if there are other config files
available"... I thought there was no short way to say that =/

-- 
Felipe Contreras
