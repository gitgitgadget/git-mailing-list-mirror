From: Jerry Qassar <jqassar@gmail.com>
Subject: Re: [PATCH] http.c: Add config options/parsing for SSL engine vars
Date: Tue, 30 Apr 2013 13:04:17 -0700
Message-ID: <CAJC3a=pU2m8LpUh0u0XXXgOiDiPo-QAdA471orGs9jcyDJTU5g@mail.gmail.com>
References: <1366758207-7724-1-git-send-email-jqassar@gmail.com>
	<7v61z4ezlz.fsf@alter.siamese.dyndns.org>
	<20130430182732.GB1972@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 30 22:04:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXGmo-0002Vi-OP
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 22:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933058Ab3D3UEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 16:04:23 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:51017 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760223Ab3D3UEV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 16:04:21 -0400
Received: by mail-la0-f44.google.com with SMTP id ed20so799361lab.31
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 13:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=tBMeGQjYJfV48cWopPEhez6LnZ6MTtf7L/HS00SnhRI=;
        b=oUlXp1oXHJSordBcUIBirGk6H/mWV/nqh/2HlrGQFr+M8B41JDWr9G6bnl6nW9e2RD
         weUVutl9QZcr6qtvI7KiiiSsYF9v10dRe4EKC4ftpbnJ89KtjRm2d2Zlw5/9p9vNg7Mz
         HjMS7nWn5OonlCuzTaM6nmMVfKnbFASZr2E3r9P5d7IPh5nPP+AHvOlZgIRtERGoHI6C
         54AdM6pOCl/yuA7lo5bQ33OPjNJe50fViG3O0rjA4yMcNXkFC4gT7DkigLbWCovrMBZu
         Mi/7nRYv2jnzdlL1NBberoTMPY6kJTzt57NRAV7Wlp2Hikst4Dn5daZ5gOvnnnCR8JFx
         eO3A==
X-Received: by 10.112.141.71 with SMTP id rm7mr201481lbb.7.1367352258201; Tue,
 30 Apr 2013 13:04:18 -0700 (PDT)
Received: by 10.112.21.230 with HTTP; Tue, 30 Apr 2013 13:04:17 -0700 (PDT)
In-Reply-To: <20130430182732.GB1972@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223000>

On Tue, Apr 30, 2013 at 11:27 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 30, 2013 at 09:45:44AM -0700, Junio C Hamano wrote:
>
>> The authoritative source
>>
>> https://github.com/bagder/curl/blob/master/docs/libcurl/symbols-in-versions
>>
>> tells me that the CURLOPT_* used in this patch are available since
>> cURL 7.9.3, but I see a #if LIBCURL_VERSION_NUM < 0x070704 in http.h
>> so these may have to be protected in a similar way.
>
> Yeah, I think we'd want to protect it with an #if. More on the exact
> version below.

First, thanks very much for taking a look at this.  I wasn't 100% certain about
the versioning to use for it (specifically the version-to-0x mapping), so any
input on that would be a big help.  I'll try to answer your questions below...

>
>> [the entire message unsnipped for reference]
>> Jerry Qassar <jqassar@gmail.com> writes:
>>
>> > curl provides many options for configuring the way it negotiates an SSL
>> > connection (with its default OpenSSL support), including ways to define
>> > the SSL engine used, and parameters to set the format of the key and
>> > certificate used.  Unfortunately, git does not parse some of the
>> > critical ones needed by curl to support PKCS#11.
>
> I don't know anything about curl's PKCS#11 support, so I can't comment
> too much on how these options work. But from my reading of the
> curl_easy_setopt(3), these look right, and I can comment on the http.c
> bits.
>
>> > * http.sslkeytype
>> >   A string variable, either PEM/DER/ENG, that sets CURLOPT_SSLKEYTYPE.
>> >   Can be set from environment using GIT_SSL_KEYTYPE.
>> > * http.sslcerttype
>> >   A string variable, either PEM/DER/ENG, that sets CURLOPT_SSLCERTTYPE.
>> >   Can be set from environment using GIT_SSL_CERTTYPE.
>> >
>> > Parsing these new variables combined with related patches to curl
>> > will allow git to support native authentication with smart cards.
>
> Current curl seems to take ENG only for the key, and assumes you have
> the certificate on disk (which should be fine, as it is not a secret). I
> can imagine that the user experience with a smartcard is better, though,
> if it can use ENG to just pull the cert straight from the card. Is that
> what your curl patches are for (my comments below are all predicated on
> that assumption)?

The concomitant curl patch(es; I need to separate them) are mentioned here:

http://curl.haxx.se/mail/lib-2013-04/0336.html

Curl already does support engine-based certificates (in code and
help).  Its problem
is that a) it doesn't yet read your engine defs out of OpenSSL config,
and b) a bug
in copying the engine data, once that's patched, to the handle that
calling apps use.

On git's side we just need to expose the proper options for setopt
configuration.  No
special work is needed to support them otherwise.

>
> Since these options are selected from a finite set, we need to consider
> who is responsible for complaining to the user when they set
> "http.sslkeytype" to "foobar". It probably makes sense to pass that
> responsibility along to curl, so that as it grows in capabilities, we do
> not have to keep adjusting our list (and it would already catch passing
> sslcerttype=ENG to versions of curl without your patches).
>
> Would we need the #if for the libcurl version to reference the new
> release of curl that has your patches? I think we don't, as existing
> versions would just complain when getting sslcerttype=ENG. IOW, it is
> not a build-time problem, but a run-time problem.

I can answer this for you as I runtime-tested this with much swearing
after making
the initial git changes. :)  It's curl's responsibility to parse what
it gets from the
setopt calls and shoot errors back--for example, when I fixed the
conf-reading and
the git option-setting but not the handle cloning, I would get:

error: crypto engine not set, can't load certificate while accessing ...

git doesn't do any validation of any curl options that I see, other
than type matching.
For example, git doesn't check the value of ssl_key itself, it just
passes it on.

>> > Note: It's difficult to test this without the related curl patches,
>> > which I will be submitting soon.  At the very least, leaving these new
>> > options unset doesn't break anything, and setting them has little
>> > effect without the back-end curl changes needed to 'turn on' PKCS#11.
>> > Any suggestions would be greatly appreciated.
>
> I think you'd be able to set the types to DER and test that, though the
> curl_easy_setopt manpage notes that a bug in OpenSSL prevents this from
> working.
>
> The ENG method, even with the right curl support, is probably going to
> be hard to test (unless there is some mock engine we can plug into
> OpenSSL for testing).
>
> I don't think we currently test even the basics of client certs in the
> test suite. A good first step might be to check that the existing sslkey
> and sslcert options work, followed by this patch and checking whether
> sslkeytype=DER works.

I can't think of a way to reliably provide a hardware-dependent engine
implementation
to the suite.  So ENG is probably out, but I can think of something to
verify PEM and
DER once I figure out how the test suite works.

>
>> >  http.sslKey::
>> >     File containing the SSL private key when fetching or pushing
>> >     over HTTPS. Can be overridden by the 'GIT_SSL_KEY' environment
>> >     variable.
>> >
>> > +http.sslKeyType::
>> > +   Specifies the format of the private key to curl as one of (PEM|DER|ENG).
>> > +   Can be overridden by the 'GIT_SSL_KEYTYPE' environment variable.
>> > +
>
> Setting this to ENG impacts how http.sslKey is interpreted (and of
> course whether http.sslEngine is used at all). We might want to mention
> that here.
>

Good point.  I'll add something in for it.

>> > @@ -211,6 +215,17 @@ static int http_options(const char *var, const char *value, void *cb)
>> >     if (!strcmp("http.useragent", var))
>> >             return git_config_string(&user_agent, var, value);
>> >
>> > +   /* Adding parsing for curl options relating to engines and */
>> > +   /* key/cert types.  This is necessary if attempting to     */
>> > +   /* specify an external engine (e.g. for smartcards.)       */
>
>   /*
>    * Style nit: our multi-line comments usually look
>    * like this. No right-hand border, and no text on
>    * the top or bottom lines.
>    */
>

Yes, my fault.

>> > +   if (!strcmp("http.sslkeytype", var))
>> > +           return git_config_string(&ssl_keytype, var, value);
>> > +   if (!strcmp("http.sslcerttype", var))
>> > +           return git_config_string(&ssl_certtype, var, value);
>> > +   if (!strcmp("http.sslengine", var))
>> > +           return git_config_string(&ssl_engine, var, value);
>
> We aren't checking the validity of the "type" fields here, which I
> think is OK. But then later, we do:
>
>> > +   if (ssl_keytype != NULL)
>> > +           curl_easy_setopt(result, CURLOPT_SSLKEYTYPE, ssl_keytype);
>> > +   if (ssl_certtype != NULL)
>> > +           curl_easy_setopt(result, CURLOPT_SSLCERTTYPE, ssl_certtype);
>
> Shouldn't we be checking the result of curl_easy_setopt for errors here
> (and when the engine cannot be loaded)?  I think we should probably die
> if the engine can't be loaded, but at the very least we'd want to warn
> the user that their settings are being ignored.

Errors are handled by curl (up to this point):

1) Setting the cert type to FOO:
error: not supported file type 'FOO' for certificate...
fatal: HTTP request failed

2) Setting the key type to FOO:
error: not supported file type for private key...
fatal: HTTP request failed

3) Setting engine type to something invalid:
 * SSL Engine 'pkcsfoo' not found (only with GIT_CURL_VERBOSE set)
error: crypto engine not set, can't load certificate...
fatal: HTTP request failed

...that last one could probably be a little better, but it's curl-managed.

>
>> > @@ -321,6 +336,22 @@ static CURL *get_curl_handle(void)
>> [...ssl handle setup...]
>
> Good, this is the right function in which to do that setup (I mention it
> mostly because some of the setup happens in get_active_slot, and we just
> fixed a bug the other day where some setup was in the wrong spot).
>
>> > +   /* Adding setting of engine-related curl SSL options. */
>> > +   if (ssl_engine != NULL) {
>> > +           curl_easy_setopt(result, CURLOPT_SSLENGINE, ssl_engine);
>
> This comment does not seem to say anything that is not already obvious,
> and seems more for the reader of the diff than a reader of the code in
> general. Such comments should stay in the commit message; I think you
> have already explained yourself well there, so we can just drop it here.
>
>> > +           /* Within the lifetime of a single git execution, setting
>> > +            * the default does nothing interesting.  When curl properly
>> > +            * duplicates handles, the engine choice will propagate.
>> > +            */
>> > +           /* curl_easy_setopt(result, CURLOPT_SSLENGINE_DEFAULT, 1L); */
>
> If it is not doing anything, we can just drop this whole block, can't
> we?
>
> I am unclear from reading the curl docs whether one would need to call
> SSLENGINE_DEFAULT or not, though. Maybe your patches have some impact on
> that.
>

No, they don't have any obvious impact and I can probably drop both comments.
Since git executions are finite, if you start with the engine you're
ending with the
same engine, and making it default for this operation doesn't affect much.

My feeling in this case is that if you step into the lair of the
engine dragon you void
your warranty.  A proper warning sign in the documentation about the
specification
of engines is probably a good idea.

>> > @@ -405,6 +436,11 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>> >                     ssl_cert_password_required = 1;
>> >     }
>> >
>> > +   /* Added environment variables for expanded engine-related options. */
>> > +   set_from_env(&ssl_keytype, "GIT_SSL_KEYTYPE");
>> > +   set_from_env(&ssl_certtype, "GIT_SSL_CERTTYPE");
>> > +   set_from_env(&ssl_engine, "GIT_SSL_ENGINE");
>
> These come after the config but before we have used the values in
> get_curl_handle, so they should properly take precedence. Good.
>
>
> Overall, I think it is looking good. Aside from a few style/cleanup
> issues, my only real complaint is the lack of error-checking from
> curl_easy_setopt.
>
> And of course adding some tests while you are working in the area would
> be very nice. :)
>

Thanks very much for the constructive input.  Once I make the corrections and
determine how to make some appropriate tests I'll resubmit.  I guess
my open question
is, if you wish to wrap the prop setting in a curl version #if, what
version is desired?
