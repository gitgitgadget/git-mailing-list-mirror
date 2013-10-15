From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rev-parse --parseopt: fix handling of optional arguments
Date: Tue, 15 Oct 2013 16:14:27 -0700
Message-ID: <20131015231427.GF9464@google.com>
References: <1381838425-18244-1-git-send-email-boklm@mars-attacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Nicolas Vigier <boklm@mars-attacks.org>
X-From: git-owner@vger.kernel.org Wed Oct 16 01:14:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWDow-00049t-PK
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 01:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933770Ab3JOXOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 19:14:31 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36112 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933560Ab3JOXOa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 19:14:30 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so9576567pdj.3
        for <git@vger.kernel.org>; Tue, 15 Oct 2013 16:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=pD3NfWzYvbsMuSHT2yOKmuMlqtKL8VitOvlD9a1xZGE=;
        b=B3bTASCo/qXa5tTbaNs03BfeEnzqhBr9x+Z1OQtOEzlxQmzQ0bCfKIkTHtQYlY6c96
         opPsL+00UFSHRY+adW3iCwbDggmgKeCEPFlkfg6NQT+kyVZQLC3vteqbWKkhWQO7t0cM
         DVEqDzm+NEQ07GSUluHnx1P/VZK/pQF+KqVJsNJT9XveDvL6Ssjgji/0BofTTFznmO8n
         zluBicQ8DIGGP++MzmiA4w3YxdiftAyTFXBCYxGpsAg/99Lu98Zt90IXg57W0oQAxW2X
         ZMjdEI3vLw4T6jQMqMLP/q8uvw8PoRaWmZhpOHPF2nxIbPTDtYedVIh1XnQBOtdv5PZg
         fLcw==
X-Received: by 10.68.76.65 with SMTP id i1mr44124689pbw.37.1381878869941;
        Tue, 15 Oct 2013 16:14:29 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id dq3sm86968485pbc.35.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Oct 2013 16:14:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1381838425-18244-1-git-send-email-boklm@mars-attacks.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236217>

Nicolas Vigier wrote:

>   $ cat /tmp/opt.sh
>   #!/bin/sh
>   OPTIONS_SPEC="\
>   git [options]
>   --
>   q,quiet         be quiet
>   S,gpg-sign?     GPG-sign commit"
>   echo "$OPTIONS_SPEC" | git rev-parse --parseopt $parseopt_extra -- "$@"
>
> Then the following two commands give us the same result :
>
>   $ /tmp/opt.sh -S -q
>   set -- -S -q --
>   $ /tmp/opt.sh -S-q
>   set -- -S '-q' --
>
> We cannot know if '-q' is an argument to '-S' or a new option.

Hmph.

As Junio mentioned, inserting '' would be a backward-incompatible
change.  I don't think it's worth breaking existing scripts.  Probably
what is needed is a new parseopt special character with the new
semantics (e.g.,

	Use ?? to mean the option has an optional argument.  If the
	option is supplied without its argument, the argument is taken
	to be ''.

or something like

	Use ?<default> to mean the option has an optional argument.  If
	the option is supplied without its argument and <default> is
	nonempty, the argument is taken to be <default>.

).

Sensible?

Thanks,
Jonathan
