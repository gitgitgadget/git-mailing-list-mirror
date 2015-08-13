From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] http: add support for specifying the SSL version
Date: Thu, 13 Aug 2015 12:11:30 -0400
Message-ID: <CAPig+cSC2a07RYioQ4+sw=pujFW8=sv_d5vv=XiayuSg7FBcHw@mail.gmail.com>
References: <1439479731-16018-1-git-send-email-gitter.spiros@gmail.com>
	<CAPig+cTug2Q3v1K5r76fhJ6OQY9V1e6MbiXQBGQJD51TCOGW=A@mail.gmail.com>
	<CA+EOSBkSkvvBQDpxL_ygj+2haMk1U7T00-Xmxn8iyXcnV6RN5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Galan_R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 18:11:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPv6N-0003tO-IF
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 18:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308AbbHMQLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 12:11:31 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:33115 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbbHMQLa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 12:11:30 -0400
Received: by ykaz130 with SMTP id z130so45427266yka.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=4LUigKEW/r4OLu+p/Ej/LyLQNSeYzl9sJvJPWOu9wTc=;
        b=Eqmh/pfK5KwniFgovqAlHyqYrjtPpGOcu+iBlMS4i0pUhTdfb4VyFCEr4nRWyyI25U
         gaJ+4rE446HlodWh5SGdpI/UbegQyG2/DskJkQSwSixmd9wsUXSp9ZrejfD1LD1yTwwT
         lsNhtxb+TGYGrjkJmcu7ww5EYETjpBdjHwJA2lf+BmdyLtuJx8lDR0XYoxZHI0j8WggN
         KZBtNnc7rttug82iHXG33axIN5eCMeMUWzF0ILuJG7UT4TsLe47M9SPwSDjN/h2lXWkd
         y849Yp+ddPbo5S0pvNyYj+BpmbO9vlVpqNKhbylZyhoC3cD5ecxm4Vy624CsPENafzkW
         Pg+A==
X-Received: by 10.13.202.80 with SMTP id m77mr13335592ywd.166.1439482290279;
 Thu, 13 Aug 2015 09:11:30 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Thu, 13 Aug 2015 09:11:30 -0700 (PDT)
In-Reply-To: <CA+EOSBkSkvvBQDpxL_ygj+2haMk1U7T00-Xmxn8iyXcnV6RN5Q@mail.gmail.com>
X-Google-Sender-Auth: sDkJagGD_nlJ2xEhGxwHaXKViJg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275855>

On Thu, Aug 13, 2015 at 11:58 AM, Elia Pinto <gitter.spiros@gmail.com> wrote:
> 2015-08-13 17:47 GMT+02:00 Eric Sunshine <sunshine@sunshineco.com>:
>> On Thu, Aug 13, 2015 at 11:28 AM, Elia Pinto <gitter.spiros@gmail.com> wrote:
>>> Teach git about a new option, "http.sslVersion", which permits one to
>>> specify the SSL version  to use when negotiating SSL connections.  The
>>> setting can be overridden by the GIT_SSL_VERSION environment
>>> variable.
>>>
>>> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>>> ---
>>> This is the third version of the patch. The changes compared to the previous version are:
>>
>> Looks better. A few comments below...
>>
>>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>>> index c97c648..6e9359c 100644
>>> --- a/contrib/completion/git-completion.bash
>>> +++ b/contrib/completion/git-completion.bash
>>> @@ -364,9 +381,22 @@ static CURL *get_curl_handle(void)
>>>         if (http_proactive_auth)
>>>                 init_curl_http_auth(result);
>>>
>>> +       if (getenv("GIT_SSL_VERSION"))
>>> +               ssl_version = getenv("GIT_SSL_VERSION");
>>> +       if (ssl_version != NULL && *ssl_version) {
>>> +               int i;
>>> +               for ( i = 0; i < ARRAY_SIZE(sslversions); i++ ) {
>>> +                       if (sslversions[i].name != NULL && *sslversions[i].name && !strcmp(ssl_version,sslversions[i].name)) {
>>
>> This sort of loop is normally either handled by indexing up to a limit
>> (ARRAY_SIZE, in this case) or by iterating until hitting a sentinel
>> (NULL, in this case). It is redundant to use both, as this code does.
> I do not think. sslversions[i].name can be null, see how the structure
> is initialized. No ?

The initialization:

    static struct {
       const char *name;
       long ssl_version;
       } sslversions[] = {
           { "sslv2", CURL_SSLVERSION_SSLv2 },
           ...
           { "tlsv1.2", CURL_SSLVERSION_TLSv1_2 },
           { NULL }
    };

terminates the list with a NULL sentinel entry, which does indeed set
sslversions[i].name to NULL. When you know the item count ahead of
time (as you do in this case), this sort of end-of-list sentinel is
redundant, and complicates the code unnecessarily. For instance, the
'sslversions[i].name != NULL' expression in the 'if':

    if (sslversions[i].name != NULL && *sslversions[i].name ...

is an unwanted complication. In fact, the '*sslversions[i].name'
expression is also unnecessary.
