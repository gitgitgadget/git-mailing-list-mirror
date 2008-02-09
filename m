From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Re: [Janitors] value could be NULL in config parser
Date: Fri, 8 Feb 2008 19:20:34 -0600
Message-ID: <5d46db230802081720x122a807do6c63b6b3e435b4c5@mail.gmail.com>
References: <7v63x0lzhw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 02:21:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNePD-0001UM-Op
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 02:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756059AbYBIBUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 20:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756013AbYBIBUg
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 20:20:36 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:42391 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbYBIBUf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 20:20:35 -0500
Received: by wx-out-0506.google.com with SMTP id h31so4256978wxd.4
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 17:20:34 -0800 (PST)
Received: by 10.150.122.13 with SMTP id u13mr802548ybc.131.1202520034845;
        Fri, 08 Feb 2008 17:20:34 -0800 (PST)
Received: by 10.150.199.5 with HTTP; Fri, 8 Feb 2008 17:20:34 -0800 (PST)
In-Reply-To: <7v63x0lzhw.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73181>

On 2/8/08, Junio C Hamano <gitster@pobox.com> wrote:
> A callback function of git_config() is called when the command
> reads value from .git/config and friends.  The function takes
> two parameters, var and value.  var is never NULL and it is the
> name of the configuration variable found in the file being
> read.  value could be either string or NULL.
>
> A NULL value is boolean "true".  For example, on MS-DOS, you may
> have something like this:
>
>         [core]
>                 autocrlf
>
> and your callback will be called with var = "core.autocrlf" and
> value = NULL in such a case.
>
> If you want to fix them (you do not have to do all of them, and
> if you would like to help, please make one patch per function
> fixed), the procedure is:
>

I think I got all the erroneous ones.  I did

find . -name "*.c" | xargs grep git_config\( | awk '{ idx = index($2,
")"); p = substr($2, 12, idx - 12); print  p }' | sort | uniq -u

To try and get a list of all the ones that might need updating.  I did
notice that most functions never check value for null, but they don't
directly access them.  They pass them off to other methods.  As far as
I can tell, some of these methods don't validate the NULL.  So they
will need to be updated.

Question.  Wouldn't it reduce the amount of validation we have to do
if whoever is calling back checked null and assigned an empty string?
If so, we can probably replace all these patches with one patch.

-Govind
