From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: I want to omit the commit log message from the log output
Date: Wed, 27 Oct 2010 14:36:50 -0500
Message-ID: <20101027193650.GA24934@burratino>
References: <18995.1288205882@relay.known.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Wed Oct 27 21:37:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBBo6-0000VC-HV
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 21:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756275Ab0J0ThF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 15:37:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53320 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756061Ab0J0ThE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 15:37:04 -0400
Received: by fxm16 with SMTP id 16so1047092fxm.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 12:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8q5xDgaUCkyChe6sIhpTLT/EYfLNU65rdVuLmOY886Q=;
        b=e0dqkpD6TafKON/JIZY/Jp2/GvDmx7JLd/zZhMwJy6v4bOzOrxh0YdYDRxCGnmVm5F
         F1LYF7mQn8yzsc77mQTMQvnUAj7ihKm4wbP+dGZ23tI4MS0gl8Q7UegzRNZ+Rchp/i34
         Hq9opb0eIUVISaRgBieLWO22l+c4cd7E2s/38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NhZoTmoHzHUW6yQ0EgVa70eEKHXIdEOTLkjRS8KEArU5QNdmuiTbIxmc2YEHvhCTQj
         qzVEfp6PF2LhDWIfldUW+hGCPdZImfggeJwmF2REcfs4nRiR6998BIAo/gfW0PUrkyQN
         rwDA3lpQKUbtgbMHWDO3Srj154aeR3BaN3IhI=
Received: by 10.223.125.207 with SMTP id z15mr2910344far.42.1288208221978;
        Wed, 27 Oct 2010 12:37:01 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id u8sm87127fah.12.2010.10.27.12.37.00
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 12:37:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <18995.1288205882@relay.known.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160118>

Hi,

layer wrote:

> I'm trying to simulate the output that comes at the end of the merge:

Cheating answer:

Hmm, I wonder how the scripted version did that.

$ git grep -Oless -eFast-forward -- contrib/examples/git-merge.sh
        msg="Fast-forward"
        if test -n "$have_message"
        then
                msg="$msg (no commit created; -m option ignored)"
        fi
        new_head=$(git rev-parse --verify "$1^0") &&
        git read-tree -v -m -u --exclude-per-directory=.gitignore $head "$new_head" &&
        finish "$new_head" "$msg" || exit
        dropsave
        exit 0
        ;;
[ok, it's the finish function.  press q to exit the pager, and]
$ git grep -Oless -F -e'finish ()' -- contrib/examples/git-merge.sh
finish () {
        if test '' = "$2"
[...]
                if test "$show_diffstat" = t
                then
                        # We want color (if set), but no pager
                        GIT_PAGER='' git diff --stat --summary -M "$head" "$1"
[...]

So apparently

	git diff --stat --summary -M <before> <after>

will take care of it.

On the other hand, if you want diff output for a single commit (i.e.,
"somewhat like git rev-list --pretty --summary --stat --no-walk but no
commit messages"), then some variation on

	git diff-tree --color --cc --summary --stat --no-commit-id origin/pu

might bring some joy.

Hope that helps,
Jonathan
