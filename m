From: Leila <muhtasib@gmail.com>
Subject: Re: [PATCH/RFC] revision: Show friendlier message.
Date: Mon, 25 Jun 2012 18:53:57 -0400
Message-ID: <CAA3EhHLy+5Vfw0T=7VEBi+2ZxjS4x2dndox+M_E06v3FtoNQXg@mail.gmail.com>
References: <1340478681-58476-1-git-send-email-muhtasib@gmail.com>
 <7vobo8hsee.fsf@alter.siamese.dyndns.org> <CAA3EhHJbKj+nbVsZtijsH+h7sFcyeBwT9K=BTeqAuMzSH0RGmg@mail.gmail.com>
 <7vr4t3f9y6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 00:54:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjIAs-0005Yw-OS
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 00:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756851Ab2FYWyT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 18:54:19 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:61059 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793Ab2FYWyS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2012 18:54:18 -0400
Received: by vcbf11 with SMTP id f11so2287721vcb.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 15:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Xx3W5bDzFvXvALKANJ9dPWUBk7ZIvgqqMdRzrRxbJJ4=;
        b=Hdx00W0QSnZ/4S7Q20ovY14vb0THwqPdM9xZ1aInb1wboPMxRJ3PGLOktLGdCfXLYR
         pmouw4He9kxEgk6+ImF+K/N+w8SAN/XLJ94bmL8Nqb594CwCHNyLwJlbbbzvnM4FMUCp
         yRriffAB8XUXaUi05ceMlgZsVQsDh6xWll8VD4tcOKxhjxyR7M4iUirP74ImTiuUcQBC
         D++c+L8L34cVkHh+kxKJAfwjBsVQ5Owvp8ICqw0+t4i3JYHPqBElmhTLBZO8YgXatPBz
         6WF+95MTus4jUhMoa3SnsSKT5IgBZqq2/hmTdkwl1/OiQeP2nkeNVe+k1lG1O0KCX88S
         xGfw==
Received: by 10.220.9.10 with SMTP id j10mr9306648vcj.7.1340664857360; Mon, 25
 Jun 2012 15:54:17 -0700 (PDT)
Received: by 10.52.37.233 with HTTP; Mon, 25 Jun 2012 15:53:57 -0700 (PDT)
In-Reply-To: <7vr4t3f9y6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200604>

On Mon, Jun 25, 2012 at 3:49 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>>> =A02. Make setup_revisions() expose got_rev_arg to its callers
>>> =A0 =A0(e.g. move it to struct rev_info);
>>
>> Do you mean have got_rev_args be a wrapper of argc and argv?
>
> No. =A0The setup_revisions() function knows if it saw a revision
> argument from the command line, but currently uses got_rev_args
> local variable, so the caller would not be able to tell. =A0I was
> suggesting to use "struct rev_info *revs" that goes in and comes out
> of the function to convey that information back to the caller.

Noted.

>
> But it turns out that it is not even needed. =A0Read on.
>
>> Or is it just a mechanism to set a signal that the calling command i=
s
>> 'log', so that I can do something about it without checking argv[0]?
>
> Didn't I already say not to switch on argv[0] in deeper side of the
> callchain?

I wasn't going to switch on argv[0], but something of the sort since I
was confused by what you meant by got_rev_args. But I understand now.

>
> Something like this, I think, would work. =A0After all, we already
> have a way to expose the revs we got from the command line to the
> caller.

This did work. I tried it out.

>
> The "bad HEAD and no revs..." part, if we choose not to even error
> on this, can be removed.

Yea, I think we should return successfully, and warning() does that.
But if we choose to display a message, I don't think it should be a
warning (esp for the empty repo case). It should look like the sample
printf below, but the v2 of the patch I submitted doesn't include the
message.

+ if (!opt.def && !rev.cmdline.nr) {
+          printf("No commit(s) to display.\n");
+          return 0;
+        }

>
> Also other cmd_frotz() functions in the same file might want to use
> the s/"HEAD"/default_to_head_if_exists()/ conversion.

Ok, I've updated other functions in the same file. See new patch. I
didn't copy paste it into this email, because the spacing will be
messed up.

Regarding this implementation:

> +static const char *default_to_head_if_exists(void)
> +{
> + =A0 =A0 =A0 unsigned char sha1[20];
> + =A0 =A0 =A0 if (resolve_ref_unsafe("HEAD", sha1, 1, NULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return "HEAD";
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +}
> +

I initially wrote something with this logic, do you have a preference?

+static const char *default_to_head_if_exists(void)
+{
+       struct commit *commit =3D lookup_commit_reference_by_name("HEAD=
");
+       if(commit)
+               return "HEAD";
+       else
+               return NULL;
+}
