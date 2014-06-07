From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH v2 5/6] Win32: Thread-safe windows console output
Date: Sat,  7 Jun 2014 09:57:24 +0200
Message-ID: <1402127845-4862-6-git-send-email-kasal@ucw.cz>
References: <20140606183935.GA4197@camelia.ucw.cz>
 <1402127845-4862-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRB2ELZOOAKGQERMNYXBI@googlegroups.com Sat Jun 07 09:57:29 2014
Return-path: <msysgit+bncBCU63DXMWULRB2ELZOOAKGQERMNYXBI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f64.google.com ([209.85.215.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB2ELZOOAKGQERMNYXBI@googlegroups.com>)
	id 1WtBVJ-0004YL-AH
	for gcvm-msysgit@m.gmane.org; Sat, 07 Jun 2014 09:57:29 +0200
Received: by mail-la0-f64.google.com with SMTP id gf5sf476676lab.9
        for <gcvm-msysgit@m.gmane.org>; Sat, 07 Jun 2014 00:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=lBnglTHgxccYTliJDiVkFv0LK8+zw+B86kBw3Ph7O0Q=;
        b=jzMNeGi2B0lCVwIvTxmGOt2nTDF6cH3kV4GjVGd58Jn44Zpa0Bt0am41+dDv5IP0gL
         nLtePkQLCPi+14VTIfh+9dswfDw7pe4QK2zM21MJNAg3to6VkXmUROfhStTO1ZjnYM1s
         u9wusycckB9Pn063uQ8m4bwYLk6IWBep8G98yumqfYTUQTnSK2CjpgTN/tHaZ1EwEKm/
         vXKLxqOnswCuzUgvscASmz5R7KAEn4W9hCKMpSDw3a5vHVpXYrtRSWbdBOp/p0BEz4Z5
         qhA3hWld5BiubU1poNJMzVFqMx8tVYorHtjPAWP/qiFZjHO23V10AAokuZpcFKCvQW8L
         FFHA==
X-Received: by 10.181.13.230 with SMTP id fb6mr39922wid.1.1402127849052;
        Sat, 07 Jun 2014 00:57:29 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.104.168 with SMTP id gf8ls212981wib.35.gmail; Sat, 07 Jun
 2014 00:57:28 -0700 (PDT)
X-Received: by 10.180.72.230 with SMTP id g6mr2267706wiv.3.1402127848078;
        Sat, 07 Jun 2014 00:57:28 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id m20si786832wij.1.2014.06.07.00.57.27
        for <msysgit@googlegroups.com>;
        Sat, 07 Jun 2014 00:57:28 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id BDA361C00AC; Sat,  7 Jun 2014 09:57:27 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402127845-4862-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251033>

From: Karsten Blees <blees@dcon.de>
Date: Sat, 14 Jan 2012 22:24:19 +0100

Winansi.c has many static variables that are accessed and modified from
the [v][f]printf / fputs functions overridden in the file. This may cause
multi threaded git commands that print to the console to produce corrupted
output or even crash.

Additionally, winansi.c doesn't override all functions that can be used to
print to the console (e.g. fwrite, write, fputc are missing), so that ANSI
escapes don't work properly for some git commands (e.g. git-grep).

Instead of doing ANSI emulation in just a few wrapped functions on top of
the IO API, let's plug into the IO system and take advantage of the thread
safety inherent to the IO system.

Redirect stdout and stderr to a pipe if they point to the console. A
background thread reads from the pipe, handles ANSI escape sequences and
UTF-8 to UTF-16 conversion, then writes to the console.

The pipe-based stdout and stderr replacements must be set to unbuffered, as
MSVCRT doesn't support line buffering and fully buffered streams are
inappropriate for console output.

Due to the byte-oriented pipe, ANSI escape sequences and multi-byte UTF-8
sequences can no longer be expected to arrive in one piece. Replace the
string-based ansi_emulate() with a simple stateful parser (this also fixes
colored diff hunk headers, which were broken as of commit 2efcc977).

Override isatty to return true for the pipes redirecting to the console.

Exec/spawn obtain the original console handle to pass to the next process
via winansi_get_osfhandle().

All other overrides are gone, the default stdio implementations work as
expected with the piped stdout/stderr descriptors.

Global variables are either initialized on startup (single threaded) or
exclusively modified by the background thread. Threads communicate through
the pipe, no further synchronization is necessary.

The background thread is terminated by disonnecting the pipe after flushing
the stdio and pipe buffers. This doesn't work for anonymous pipes (created
via CreatePipe), as DisconnectNamedPipe only works on the read end, which
discards remaining data. Thus we have to setup the pipe manually, with the
write end beeing the server (opened with CreateNamedPipe) and the read end
the client (opened with CreateFile).

Limitations: doesn't track reopened or duped file descriptors, i.e.:
- fdopen(1/2) returns fully buffered streams
- dup(1/2), dup2(1/2) returns normal pipe descriptors (i.e. isatty() =
  false, winansi_get_osfhandle won't return the original console handle)

Currently, only the git-format-patch command uses xfdopen(xdup(1)) (see
"realstdout" in builtin/log.c), but works well with these limitations.

Many thanks to Atsushi Nakagawa <atnak@chejz.com> for suggesting and
reviewing the thread-exit-mechanism.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c   |   9 +-
 compat/mingw.h   |  12 +-
 compat/winansi.c | 401 ++++++++++++++++++++++++++++++++++++-------------------
 3 files changed, 273 insertions(+), 149 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 6f1fb10..d242557 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -865,9 +865,9 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
 	memset(&si, 0, sizeof(si));
 	si.cb = sizeof(si);
 	si.dwFlags = STARTF_USESTDHANDLES;
-	si.hStdInput = (HANDLE) _get_osfhandle(fhin);
-	si.hStdOutput = (HANDLE) _get_osfhandle(fhout);
-	si.hStdError = (HANDLE) _get_osfhandle(fherr);
+	si.hStdInput = winansi_get_osfhandle(fhin);
+	si.hStdOutput = winansi_get_osfhandle(fhout);
+	si.hStdError = winansi_get_osfhandle(fherr);
 
 	/* concatenate argv, quoting args as we go */
 	strbuf_init(&args, 0);
@@ -1946,4 +1946,7 @@ void mingw_startup()
 	_setmode(_fileno(stdin), _O_BINARY);
 	_setmode(_fileno(stdout), _O_BINARY);
 	_setmode(_fileno(stderr), _O_BINARY);
+
+	/* initialize Unicode console */
+	winansi_init();
 }
diff --git a/compat/mingw.h b/compat/mingw.h
index 921ba08..4b638d8 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -317,14 +317,10 @@ int mingw_raise(int sig);
  * ANSI emulation wrappers
  */
 
-int winansi_fputs(const char *str, FILE *stream);
-int winansi_printf(const char *format, ...) __attribute__((format (printf, 1, 2)));
-int winansi_fprintf(FILE *stream, const char *format, ...) __attribute__((format (printf, 2, 3)));
-int winansi_vfprintf(FILE *stream, const char *format, va_list list);
-#define fputs winansi_fputs
-#define printf(...) winansi_printf(__VA_ARGS__)
-#define fprintf(...) winansi_fprintf(__VA_ARGS__)
-#define vfprintf winansi_vfprintf
+void winansi_init(void);
+int winansi_isatty(int fd);
+HANDLE winansi_get_osfhandle(int fd);
+#define isatty winansi_isatty
 
 /*
  * git specific compatibility
diff --git a/compat/winansi.c b/compat/winansi.c
index bec6713..fcdd6dc 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -4,18 +4,13 @@
 
 #undef NOGDI
 #include "../git-compat-util.h"
-#include <malloc.h>
 #include <wingdi.h>
 #include <winreg.h>
 
 /*
  Functions to be wrapped:
 */
-#undef printf
-#undef fprintf
-#undef fputs
-#undef vfprintf
-/* TODO: write */
+#undef isatty
 
 /*
  ANSI codes used by git: m, K
@@ -28,7 +23,10 @@ static HANDLE console;
 static WORD plain_attr;
 static WORD attr;
 static int negative;
-static FILE *last_stream = NULL;
+static int non_ascii_used = 0;
+static HANDLE hthread, hread, hwrite;
+static HANDLE hwrite1 = INVALID_HANDLE_VALUE, hwrite2 = INVALID_HANDLE_VALUE;
+static HANDLE hconsole1, hconsole2;
 
 #ifdef __MINGW32__
 typedef struct _CONSOLE_FONT_INFOEX {
@@ -44,27 +42,19 @@ typedef struct _CONSOLE_FONT_INFOEX {
 typedef BOOL (WINAPI *PGETCURRENTCONSOLEFONTEX)(HANDLE, BOOL,
 		PCONSOLE_FONT_INFOEX);
 
-static void print_font_warning(void)
+static void warn_if_raster_font(void)
 {
-	warning("Your console font probably doesn\'t support Unicode. If "
-		"you experience strange characters in the output, consider "
-		"switching to a TrueType font such as Lucida Console!");
-}
-
-static void check_truetype_font(void)
-{
-	static int truetype_font_checked;
 	DWORD fontFamily = 0;
 	PGETCURRENTCONSOLEFONTEX pGetCurrentConsoleFontEx;
 
-	/* don't do this twice */
-	if (truetype_font_checked)
+	/* don't bother if output was ascii only */
+	if (!non_ascii_used)
 		return;
-	truetype_font_checked = 1;
 
 	/* GetCurrentConsoleFontEx is available since Vista */
 	pGetCurrentConsoleFontEx = (PGETCURRENTCONSOLEFONTEX) GetProcAddress(
-			GetModuleHandle("kernel32.dll"), "GetCurrentConsoleFontEx");
+			GetModuleHandle("kernel32.dll"),
+			"GetCurrentConsoleFontEx");
 	if (pGetCurrentConsoleFontEx) {
 		CONSOLE_FONT_INFOEX cfi;
 		cfi.cbSize = sizeof(cfi);
@@ -73,8 +63,8 @@ static void check_truetype_font(void)
 	} else {
 		/* pre-Vista: check default console font in registry */
 		HKEY hkey;
-		if (ERROR_SUCCESS == RegOpenKeyExA(HKEY_CURRENT_USER, "Console", 0,
-				KEY_READ, &hkey)) {
+		if (ERROR_SUCCESS == RegOpenKeyExA(HKEY_CURRENT_USER, "Console",
+				0, KEY_READ, &hkey)) {
 			DWORD size = sizeof(fontFamily);
 			RegQueryValueExA(hkey, "FontFamily", NULL, NULL,
 					(LPVOID) &fontFamily, &size);
@@ -82,61 +72,64 @@ static void check_truetype_font(void)
 		}
 	}
 
-	if (!(fontFamily & TMPF_TRUETYPE))
-		atexit(print_font_warning);
+	if (!(fontFamily & TMPF_TRUETYPE)) {
+		const wchar_t *msg = L"\nWarning: Your console font probably "
+			L"doesn\'t support Unicode. If you experience strange "
+			L"characters in the output, consider switching to a "
+			L"TrueType font such as Consolas!\n";
+		DWORD dummy;
+		WriteConsoleW(console, msg, wcslen(msg), &dummy, NULL);
+	}
 }
 
-static int is_console(FILE *stream)
+static int is_console(int fd)
 {
 	CONSOLE_SCREEN_BUFFER_INFO sbi;
 	HANDLE hcon;
 
 	static int initialized = 0;
 
-	/* use cached value if stream hasn't changed */
-	if (stream == last_stream)
-		return console != NULL;
-
-	last_stream = stream;
-	console = NULL;
-
-	/* get OS handle of the stream */
-	hcon = (HANDLE) _get_osfhandle(_fileno(stream));
+	/* get OS handle of the file descriptor */
+	hcon = (HANDLE) _get_osfhandle(fd);
 	if (hcon == INVALID_HANDLE_VALUE)
 		return 0;
 
+	/* check if its a device (i.e. console, printer, serial port) */
+	if (GetFileType(hcon) != FILE_TYPE_CHAR)
+		return 0;
+
 	/* check if its a handle to a console output screen buffer */
 	if (!GetConsoleScreenBufferInfo(hcon, &sbi))
 		return 0;
 
+	/* initialize attributes */
 	if (!initialized) {
 		attr = plain_attr = sbi.wAttributes;
 		negative = 0;
 		initialized = 1;
 	}
 
-	console = hcon;
 	return 1;
 }
 
-static int write_console(const char *str, size_t len)
+#define BUFFER_SIZE 4096
+#define MAX_PARAMS 16
+
+static void write_console(unsigned char *str, size_t len)
 {
-	/* convert utf-8 to utf-16, write directly to console */
-	int wlen = MultiByteToWideChar(CP_UTF8, 0, str, len, NULL, 0);
-	wchar_t *wbuf = (wchar_t *) alloca(wlen * sizeof(wchar_t));
-	MultiByteToWideChar(CP_UTF8, 0, str, len, wbuf, wlen);
+	/* only called from console_thread, so a static buffer will do */
+	static wchar_t wbuf[2 * BUFFER_SIZE + 1];
+	DWORD dummy;
 
-	WriteConsoleW(console, wbuf, wlen, NULL, NULL);
+	/* convert utf-8 to utf-16 */
+	int wlen = xutftowcsn(wbuf, (char*) str, ARRAY_SIZE(wbuf), len);
 
-	/*
-	 * if non-ascii characters are printed, check that the current console
-	 * font supports this
-	 */
-	if (wlen != len)
-		check_truetype_font();
+	/* write directly to console */
+	WriteConsoleW(console, wbuf, wlen, &dummy, NULL);
 
-	/* return original (utf-8 encoded) length */
-	return len;
+	/* remember if non-ascii characters are printed */
+	if (wlen != len)
+		non_ascii_used = 1;
 }
 
 #define FOREGROUND_ALL (FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE)
@@ -182,18 +175,13 @@ static void erase_in_line(void)
 		&dummy);
 }
 
-
-static const char *set_attr(const char *str)
+static void set_attr(char func, const int *params, int paramlen)
 {
-	const char *func;
-	size_t len = strspn(str, "0123456789;");
-	func = str + len;
-
-	switch (*func) {
+	int i;
+	switch (func) {
 	case 'm':
-		do {
-			long val = strtol(str, (char **)&str, 10);
-			switch (val) {
+		for (i = 0; i < paramlen; i++) {
+			switch (params[i]) {
 			case 0: /* reset */
 				attr = plain_attr;
 				negative = 0;
@@ -316,9 +304,7 @@ static const char *set_attr(const char *str)
 				/* Unsupported code */
 				break;
 			}
-			str++;
-		} while (*(str-1) == ';');
-
+		}
 		set_console_attr();
 		break;
 	case 'K':
@@ -328,112 +314,251 @@ static const char *set_attr(const char *str)
 		/* Unsupported code */
 		break;
 	}
-
-	return func + 1;
 }
 
-static int ansi_emulate(const char *str, FILE *stream)
-{
-	int rv = 0;
-	const char *pos = str;
+enum {
+	TEXT = 0, ESCAPE = 033, BRACKET = '['
+};
 
-	fflush(stream);
+static DWORD WINAPI console_thread(LPVOID unused)
+{
+	unsigned char buffer[BUFFER_SIZE];
+	DWORD bytes;
+	int start, end = 0, c, parampos = 0, state = TEXT;
+	int params[MAX_PARAMS];
+
+	while (1) {
+		/* read next chunk of bytes from the pipe */
+		if (!ReadFile(hread, buffer + end, BUFFER_SIZE - end, &bytes,
+				NULL)) {
+			/* exit if pipe has been closed or disconnected */
+			if (GetLastError() == ERROR_PIPE_NOT_CONNECTED ||
+					GetLastError() == ERROR_BROKEN_PIPE)
+				break;
+			/* ignore other errors */
+			continue;
+		}
 
-	while (*pos) {
-		pos = strstr(str, "\033[");
-		if (pos) {
-			size_t len = pos - str;
+		/* scan the bytes and handle ANSI control codes */
+		bytes += end;
+		start = end = 0;
+		while (end < bytes) {
+			c = buffer[end++];
+			switch (state) {
+			case TEXT:
+				if (c == ESCAPE) {
+					/* print text seen so far */
+					if (end - 1 > start)
+						write_console(buffer + start,
+							end - 1 - start);
+
+					/* then start parsing escape sequence */
+					start = end - 1;
+					memset(params, 0, sizeof(params));
+					parampos = 0;
+					state = ESCAPE;
+				}
+				break;
+
+			case ESCAPE:
+				/* continue if "\033[", otherwise bail out */
+				state = (c == BRACKET) ? BRACKET : TEXT;
+				break;
+
+			case BRACKET:
+				/* parse [0-9;]* into array of parameters */
+				if (c >= '0' && c <= '9') {
+					params[parampos] *= 10;
+					params[parampos] += c - '0';
+				} else if (c == ';') {
+					/*
+					 * next parameter, bail out if out of
+					 * bounds
+					 */
+					parampos++;
+					if (parampos >= MAX_PARAMS)
+						state = TEXT;
+				} else {
+					/*
+					 * end of escape sequence, change
+					 * console attributes
+					 */
+					set_attr(c, params, parampos + 1);
+					start = end;
+					state = TEXT;
+				}
+				break;
+			}
+		}
 
-			if (len) {
-				size_t out_len = write_console(str, len);
-				rv += out_len;
-				if (out_len < len)
-					return rv;
+		/* print remaining text unless parsing an escape sequence */
+		if (state == TEXT && end > start) {
+			/* check for incomplete UTF-8 sequences and fix end */
+			if (buffer[end - 1] >= 0x80) {
+				if (buffer[end -1] >= 0xc0)
+					end--;
+				else if (end - 1 > start &&
+						buffer[end - 2] >= 0xe0)
+					end -= 2;
+				else if (end - 2 > start &&
+						buffer[end - 3] >= 0xf0)
+					end -= 3;
 			}
 
-			str = pos + 2;
-			rv += 2;
+			/* print remaining complete UTF-8 sequences */
+			if (end > start)
+				write_console(buffer + start, end - start);
 
-			pos = set_attr(str);
-			rv += pos - str;
-			str = pos;
+			/* move remaining bytes to the front */
+			if (end < bytes)
+				memmove(buffer, buffer + end, bytes - end);
+			end = bytes - end;
 		} else {
-			size_t len = strlen(str);
-			rv += write_console(str, len);
-			return rv;
+			/* all data has been consumed, mark buffer empty */
+			end = 0;
 		}
 	}
-	return rv;
-}
-
-int winansi_fputs(const char *str, FILE *stream)
-{
-	int rv;
-
-	if (!is_console(stream))
-		return fputs(str, stream);
 
-	rv = ansi_emulate(str, stream);
+	/* check if the console font supports unicode */
+	warn_if_raster_font();
 
-	if (rv >= 0)
-		return 0;
-	else
-		return EOF;
+	CloseHandle(hread);
+	return 0;
 }
 
-int winansi_vfprintf(FILE *stream, const char *format, va_list list)
+static void winansi_exit(void)
 {
-	int len, rv;
-	char small_buf[256];
-	char *buf = small_buf;
-	va_list cp;
-
-	if (!is_console(stream))
-		goto abort;
+	/* flush all streams */
+	_flushall();
+
+	/* signal console thread to exit */
+	FlushFileBuffers(hwrite);
+	DisconnectNamedPipe(hwrite);
+
+	/* wait for console thread to copy remaining data */
+	WaitForSingleObject(hthread, INFINITE);
+
+	/* cleanup handles... */
+	if (hwrite1 != INVALID_HANDLE_VALUE)
+		CloseHandle(hwrite1);
+	if (hwrite2 != INVALID_HANDLE_VALUE)
+		CloseHandle(hwrite2);
+	CloseHandle(hwrite);
+	CloseHandle(hthread);
+}
 
-	va_copy(cp, list);
-	len = vsnprintf(small_buf, sizeof(small_buf), format, cp);
-	va_end(cp);
+static void die_lasterr(const char *fmt, ...)
+{
+	va_list params;
+	va_start(params, fmt);
+	errno = err_win_to_posix(GetLastError());
+	die_errno(fmt, params);
+	va_end(params);
+}
 
-	if (len > sizeof(small_buf) - 1) {
-		buf = malloc(len + 1);
-		if (!buf)
-			goto abort;
+static HANDLE duplicate_handle(HANDLE hnd)
+{
+	HANDLE hresult, hproc = GetCurrentProcess();
+	if (!DuplicateHandle(hproc, hnd, hproc, &hresult, 0, TRUE,
+			DUPLICATE_SAME_ACCESS))
+		die_lasterr("DuplicateHandle(%li) failed", (long) hnd);
+	return hresult;
+}
 
-		len = vsnprintf(buf, len + 1, format, list);
-	}
+static HANDLE redirect_console(FILE *stream, HANDLE *phcon, int new_fd)
+{
+	/* get original console handle */
+	int fd = _fileno(stream);
+	HANDLE hcon = (HANDLE) _get_osfhandle(fd);
+	if (hcon == INVALID_HANDLE_VALUE)
+		die_errno("_get_osfhandle(%i) failed", fd);
 
-	rv = ansi_emulate(buf, stream);
+	/* save a copy to phcon and console (used by the background thread) */
+	console = *phcon = duplicate_handle(hcon);
 
-	if (buf != small_buf)
-		free(buf);
-	return rv;
+	/* duplicate new_fd over fd (closes fd and associated handle (hcon)) */
+	if (_dup2(new_fd, fd))
+		die_errno("_dup2(%i, %i) failed", new_fd, fd);
 
-abort:
-	rv = vfprintf(stream, format, list);
-	return rv;
+	/* no buffering, or stdout / stderr will be out of sync */
+	setbuf(stream, NULL);
+	return (HANDLE) _get_osfhandle(fd);
 }
 
-int winansi_fprintf(FILE *stream, const char *format, ...)
+void winansi_init(void)
 {
-	va_list list;
-	int rv;
+	int con1, con2, hwrite_fd;
+	char name[32];
 
-	va_start(list, format);
-	rv = winansi_vfprintf(stream, format, list);
-	va_end(list);
+	/* check if either stdout or stderr is a console output screen buffer */
+	con1 = is_console(1);
+	con2 = is_console(2);
+	if (!con1 && !con2)
+		return;
 
-	return rv;
+	/* create a named pipe to communicate with the console thread */
+	sprintf(name, "\\\\.\\pipe\\winansi%lu", GetCurrentProcessId());
+	hwrite = CreateNamedPipe(name, PIPE_ACCESS_OUTBOUND,
+		PIPE_TYPE_BYTE | PIPE_WAIT, 1, BUFFER_SIZE, 0, 0, NULL);
+	if (hwrite == INVALID_HANDLE_VALUE)
+		die_lasterr("CreateNamedPipe failed");
+
+	hread = CreateFile(name, GENERIC_READ, 0, NULL, OPEN_EXISTING, 0, NULL);
+	if (hread == INVALID_HANDLE_VALUE)
+		die_lasterr("CreateFile for named pipe failed");
+
+	/* start console spool thread on the pipe's read end */
+	hthread = CreateThread(NULL, 0, console_thread, NULL, 0, NULL);
+	if (hthread == INVALID_HANDLE_VALUE)
+		die_lasterr("CreateThread(console_thread) failed");
+
+	/* schedule cleanup routine */
+	if (atexit(winansi_exit))
+		die_errno("atexit(winansi_exit) failed");
+
+	/* create a file descriptor for the write end of the pipe */
+	hwrite_fd = _open_osfhandle((long) duplicate_handle(hwrite), _O_BINARY);
+	if (hwrite_fd == -1)
+		die_errno("_open_osfhandle(%li) failed", (long) hwrite);
+
+	/* redirect stdout / stderr to the pipe */
+	if (con1)
+		hwrite1 = redirect_console(stdout, &hconsole1, hwrite_fd);
+	if (con2)
+		hwrite2 = redirect_console(stderr, &hconsole2, hwrite_fd);
+
+	/* close pipe file descriptor (also closes the duped hwrite) */
+	close(hwrite_fd);
 }
 
-int winansi_printf(const char *format, ...)
+static int is_same_handle(HANDLE hnd, int fd)
 {
-	va_list list;
-	int rv;
+	return hnd != INVALID_HANDLE_VALUE && hnd == (HANDLE) _get_osfhandle(fd);
+}
 
-	va_start(list, format);
-	rv = winansi_vfprintf(stdout, format, list);
-	va_end(list);
+/*
+ * Return true if stdout / stderr is a pipe redirecting to the console.
+ */
+int winansi_isatty(int fd)
+{
+	if (fd == 1 && is_same_handle(hwrite1, 1))
+		return 1;
+	else if (fd == 2 && is_same_handle(hwrite2, 2))
+		return 1;
+	else
+		return isatty(fd);
+}
 
-	return rv;
+/*
+ * Returns the real console handle if stdout / stderr is a pipe redirecting
+ * to the console. Allows spawn / exec to pass the console to the next process.
+ */
+HANDLE winansi_get_osfhandle(int fd)
+{
+	if (fd == 1 && is_same_handle(hwrite1, 1))
+		return hconsole1;
+	else if (fd == 2 && is_same_handle(hwrite2, 2))
+		return hconsole2;
+	else
+		return (HANDLE) _get_osfhandle(fd);
 }
-- 
2.0.0.9635.g0be03cb

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
