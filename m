From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH/RFC 1/7] git-submodule: Extract functions module_info and module_url
Date: Sat, 12 Apr 2008 11:05:23 +0800
Message-ID: <46dff0320804112005t9b3cd27gc250dddffb218076@mail.gmail.com>
References: <1207842625-9210-1-git-send-email-pkufranky@gmail.com>
	 <1207842625-9210-2-git-send-email-pkufranky@gmail.com>
	 <7v4pa8qb2h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Junio C Hamano" <junio@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 05:06:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkW4G-0007rL-Rj
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 05:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756446AbYDLDFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 23:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756087AbYDLDFZ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 23:05:25 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:28261 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756423AbYDLDFY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 23:05:24 -0400
Received: by an-out-0708.google.com with SMTP id d31so176776and.103
        for <git@vger.kernel.org>; Fri, 11 Apr 2008 20:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=e3jiqvp5Fgpz/qrc29XUeqOkSgvQlFyPXZdIFv2s0JM=;
        b=YrrBVsMbRxF9kAsXdM1X6wcHN/Nh9UH5CEqS71xzh5Wh3IeSbcS32+M75Xj+/z6i0ojXZzVJ3NmFztGtCS87+Qr/E+4achPlIEPdre68x0q3+lOD+EUkGJUvlmHVClTD/5lUiBMmTs8CXCGlnoGQcWwORhITHGY/OJ/Qgo5RrUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=wUyeEfChbw+OuBl5fpZxchT3F3yYIFxLwuH6C69nqvsCScqy3EjFHHEpbElbqFWzTc3AeVQAZ8gfmHPFsTmehGwMd/TZrkcRkZV82jxrINjrIEdUTRcGXWOticLqgb80ViHYZPCS67CclWgPiRbAe1+WvzWc5PBiFtuENTuGYYQ=
Received: by 10.100.43.13 with SMTP id q13mr153651anq.159.1207969523409;
        Fri, 11 Apr 2008 20:05:23 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Fri, 11 Apr 2008 20:05:23 -0700 (PDT)
In-Reply-To: <7v4pa8qb2h.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79324>

On Sat, Apr 12, 2008 at 6:30 AM, Junio C Hamano <junio@pobox.com> wrote:
> Ping Yin <pkufranky@gmail.com> writes:
>
>  > @@ -232,12 +251,11 @@ cmd_init()
>  >               shift
>  >       done
>  >
>  > -     git ls-files --stage -- "$@" | grep '^160000 ' |
>  > -     while read mode sha1 stage path
>  > +     module_info "$@" |
>  > +     while read sha1 path name url
>  >       do
>  > +             test -n "$name" || exit
>  >               # Skip already registered paths
>  > -             name=$(module_name "$path") || exit
>  > -             url=$(git config submodule."$name".url)
>  >               test -z "$url" || continue
>
>  This is not a new bug in this round of patch (i.e. the original code
>  already did the same), but I have to wonder if exiting the loop silently
>  when $name is not set (i.e. .gitmodules does not have an entry to describe
>  the submodule yet) is a good idea.
>
>  If an entry with mode 160000 in the index is an error if it does not have
>  a corresponding entry in .gitmodules, then this code should say so when
>  exiting the loop prematurely.  If it is not, I think it should silently
>  continue just like missing URL case.
>
>  The user may be right in the process of manually adding a new submodule,
>  has done "git add" of the submodule path already but hasn't yet decided
>  what the name of the submodule or where the final published URL would be.
>  In such a case, you would have 160000 entry in the index that does not
>  have a corresponding entry in .gitmodules and that is perfectly valid.
>
>  So I tend to think that you should treat "missing name" and "missing url"
>  as an non-error case.
>
>  cmd_init would obviously need to _notice_ "missing url" and refrain from
>  adding the missing remote URL to the config, but I do not think it should
>  error out.  Warning might be appropriate in cases, but I dunno.
>
>  Same comment applies to cmd_update() and cmd_status().  I would strongly
>  suspect that status may want to ignore missing name/url and show the usual
>  diff, as it does not even have to require the submodule to interact with
>  any remote repository at all.  The user may be privately using the
>  submodule and does not even need to push it out nor pull it from
>  elsewhere, and in such a case, .gitmodules may not even be populated with
>  an entry for that submodule, ever, not just as a "right in the middle of
>  adding" status.

This patch just does refactor, i do this in my sixth patch "Don't die
when command fails for one submodule"


-- 
Ping Yin
